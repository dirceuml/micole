class AutorizacionesController < ApplicationController
  load_and_authorize_resource
  
  # GET /autorizaciones
  # GET /autorizaciones.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    if params[:accion].nil? || params[:accion] == "consultar"
      actividad = params[:actividad_id]
      if params[:seccion_id].nil?
        seccion = ""
      else
        seccion = params[:seccion_id]
      end

      @autorizaciones = Autorizacion.por_actividad(actividad).order("alumnos.apellido_paterno, alumnos.apellido_materno, alumnos.nombres").por_seccion(anio_escolar.id, seccion)
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @autorizaciones }
      end
    else
      if params[:accion] == "autorizar"
        @autorizaciones = Autorizacion.persona_autorizada(PersonaVinculada.logueado(params[:usuario]).pluck("personas_vinculadas.id"))
        
        respond_to do |format|
          format.html { render :autorizacion, :usuario => "cvargas" }# index.html.erb
          format.json { render json: @autorizaciones }
        end
      end
    end   
  end
  
  
  def asistencias_actividades
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    actividad = params[:actividad_id]
    if params[:seccion_id].nil?
      seccion = ""
    else
      seccion = params[:seccion_id]
    end
    
    @autorizaciones = Autorizacion.por_actividad(actividad).por_seccion(anio_escolar.id, seccion).order("alumnos.apellido_paterno, alumnos.apellido_materno, alumnos.nombres")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @autorizaciones }
    end
  end
  
  
  def grabar_asistencias
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    if params[:alumno_id].nil?
      flash[:notice] = 'Seleccione a los alumnos asistentes a la actividad'
      redirect_to :controller => 'autorizaciones', :action => 'asistencias_actividades', :actividad_id => params[:actividad_id], :seccion_id => params[:seccion_id]
      return
    end
    
    @actividad = Actividad.find(params[:actividad_id])
    
    notificado = 0
    ActiveRecord::Base.transaction do
      params[:alumnos_seccion].each do |alumno|
        asistencia = 0
        if params[:alumno_id].include? alumno
          asistencia  = 1
        end
        @autorizacion = Autorizacion.find_by_actividad_id_and_alumno_id(params[:actividad_id],alumno)
        @autorizacion.update_attributes!(
              :asistencia => asistencia
              )
        if asistencia == 0    # inasistencia
          if colegio.notificar_inasistencia != 0
            @notificar = PersonaVinculada.padres_de(alumno)  # apoderado = 1
            if !@notificar.empty?
              notificado = 1
              @notificar.each do |padre|
                @alumno  = Alumno.find(alumno)
                InasistenciaActividadMailer.delay.notificacion_inasistencia_actividad(@alumno, padre, @actividad, Time.now.strftime('%I:%M %P')) # Asincrono
              end
            end
          end
        end
      end
      
      @actividad.update_attributes!(
        :estado => 5    ## Actividad ejecutada
      )
    end
    
    if notificado = 1
      flash[:notice] = 'Las asistencias fueron registrados satisfactoriamente y se enviaron notificaciones por inasistencia'
    else
      flash[:notice] = 'Las asistencias fueron registrados satisfactoriamente'  
    end
    redirect_to :controller => 'autorizaciones', :action => 'asistencias_actividades', :actividad_id => params[:actividad_id], :seccion_id => params[:seccion_id]
    
  end
  
  
  # GET /autorizaciones/1
  # GET /autorizaciones/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @autorizacion = Autorizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @autorizacion }
    end
  end

  # GET /autorizaciones/new
  # GET /autorizaciones/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @autorizacion = Autorizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @autorizacion }
    end
  end

  # GET /autorizaciones/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @autorizacion = Autorizacion.find(params[:id])
  end

  # POST /autorizaciones
  # POST /autorizaciones.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    if current_user.clave_hash != BCrypt::Engine.hash_secret(params[:clave], current_user.clave_salt) then
      flash[:alert] = "Clave incorrecta."
      render "new" and return
    end

    @autorizacion = Autorizacion.new(params[:autorizacion])
    
    respond_to do |format|
      if @autorizacion.save
        format.html { redirect_to @autorizacion, notice: 'Autorizacion was successfully created.' }
        format.json { render json: @autorizacion, status: :created, location: @autorizacion }
      else
        format.html { render action: "new" }
        format.json { render json: @autorizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /autorizaciones/1
  # PUT /autorizaciones/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    if current_user.clave_hash != BCrypt::Engine.hash_secret(params[:clave], current_user.clave_salt) then
      flash[:alert] = "Clave incorrecta."
      render "edit" and return
    end
    
    @autorizacion = Autorizacion.find(params[:id])

    respond_to do |format|
      if @autorizacion.update_attributes(params[:autorizacion])
        format.html { redirect_to @autorizacion, notice: 'Respuesta fue actualizada satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @autorizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /autorizaciones/1
  # DELETE /autorizaciones/1.json
  def destroy
    @autorizacion = Autorizacion.find(params[:id])
    @autorizacion.destroy

    respond_to do |format|
      format.html { redirect_to autorizaciones_url }
      format.json { head :no_content }
    end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to menu_url, :alert => exception.message
    end
  end
end
