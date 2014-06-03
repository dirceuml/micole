class AlumnosController < ApplicationController
  load_and_authorize_resource
  
  # GET /alumnos
  # GET /alumnos.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    seccion_id = params[:seccion_id]
    
    if seccion_id.nil? || seccion_id == ""
      @alumnos = Alumno.por_anio_escolar(anio_escolar.id)
    else
      @alumnos = Alumno.pertenecen_a_seccion(anio_escolar.id, seccion_id)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end
  end
  
  # GET /vincularpersona
  # GET /vincularpersona.json
  def alumnoseccion
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    seccion = params[:seccion_id]
    
    if !seccion.nil?
      @alumnos = Alumno.pertenecen_a_seccion(anio_escolar.id, seccion)
    else
      @alumnos = Alumno.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end
  end
  
  # GET /vincularpersona/1
  # GET /vincularpersona/1.json
  def alumnopersona        # vincularpersona
    @alumno = Alumno.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno }
    end
  end  
  
  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
    @alumno = Alumno.find(params[:id])    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno }
    end
  end
  

  # GET /alumnos/new
  # GET /alumnos/new.json
  def new
    @alumno = Alumno.new   
    @alumno.alumnos_personas_vinculadas.build
    @persona_vinculada = PersonaVinculada.no_vinculadas_a(@alumno.id).sort_by{|e| e[:apellido_paterno] + " " + e[:apellido_materno] + " " + e[:nombres]}
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno }
    end
  end

  # GET /alumnos/1/edit
  def edit
    @alumno = Alumno.find(params[:id])
    @seccion_id = Alumno.find(@alumno.id).seccion_id(anio_escolar.id)
    @persona_vinculada = PersonaVinculada.order("apellido_paterno, apellido_materno, nombres")
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    if params[:alumno][:alumnos_personas_vinculadas_attributes].nil?
      @seccion_id = params[:seccion_id]  
      flash[:notice] = "Debe vincular una persona"
      render "new"
    else
      @alumno = Alumno.new(params[:alumno])  
      seccion_id = params[:seccion_id]    

      respond_to do |format|
        ActiveRecord::Base.transaction do
          if @alumno.save
            AnioAlumno.create!(
              :anio_escolar_id => anio_escolar.id,
              :alumno_id => @alumno.id,
              :usuario => current_user.usuario,
              :seccion_id => seccion_id,
              :estado => 1
            )

            format.html { redirect_to @alumno, notice: 'El alumno fue creado satisfactoriamente.' }
            format.json { render json: @alumno, status: :created, location: @alumno }
          else
            format.html { render action: "new" }
            format.json { render json: @alumno.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PUT /alumnos/1
  # PUT /alumnos/1.json
  def update
    if params[:alumno][:alumnos_personas_vinculadas_attributes].nil?
      flash[:notice] = "Debe vincular una persona"
      render "edit"
    else
      @alumno = Alumno.find(params[:id])
      seccion_id = params[:seccion_id] 

      respond_to do |format|
        ActiveRecord::Base.transaction do
          if @alumno.update_attributes(params[:alumno])
            anio_alumno = AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, @alumno.id)
            anio_alumno.update_attributes!(
              :usuario => current_user.usuario,
              :seccion_id => seccion_id
            )

            format.html { redirect_to @alumno, notice: 'El alumno fue actualizado satisfactoriamente.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @alumno.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno = Alumno.find(params[:id])
    @alumno.destroy

    respond_to do |format|
      format.html { redirect_to alumnos_url }
      format.json { head :no_content }
    end
  end
  
  def alumnos_personas_vinculadas
    @alumnos = Alumno.all
    @personas_vinculadas = @PersonaVinculada.all
  end
  
  def inasistencias
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    seccion = params[:seccion_id]
    if params[:seccion_id].nil?
      seccion = 0
    end
    
    @alumnos = Alumno.pertenecen_a_seccion(anio_escolar.id, seccion).order("apellido_paterno, apellido_materno, nombres")    
        
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end    
  end
  
  def tardanzas
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @alumnos = Alumno.por_anio_escolar(anio_escolar.id).order("apellido_paterno, apellido_materno, nombres")    
    
    @registrartardanza = 1
    if !colegio.hora_inicio_tardanza.nil?
      if colegio.hora_inicio_tardanza.strftime('%H%M') > Time.now.strftime('%H%M')
        flash[:notice] = "No es la hora para registrar tardanzas. Hora de inicio: #{colegio.hora_inicio_tardanza.strftime('%I:%M %P')} "
        @registrartardanza = 0
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end    
  end

  
  def consultar_inasistencias_tardanzas
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    seccion = params[:seccion_id]
    if params[:seccion_id].nil?
      seccion = 0
      fechaI = Date.current
      fechaF = Date.current
    else
      fechaI = params[:fechaI].to_date
      fechaF = params[:fechaF].to_date
    end
    
    if anio_escolar.inicio_clases.nil?
      @fecha_inicial = Date.current.beginning_of_year # o Date.civil(anio_escolar.anio, -1, -1)
    else
      @fecha_inicial = anio_escolar.inicio_clases
    end
    
    if fechaI > fechaF
      flash[:notice] = 'Ingrese correctamente los rangos de fecha'
      redirect_to(:consultar_inasistencias_tardanzas) and return      
    else
      @alumnos = Alumno.pertenecen_a_seccion(anio_escolar.id, seccion).order("apellido_paterno, apellido_materno, nombres")
      @controles_asistencias = ControlAsistencia.por_anio_escolar_seccion_rango_fechas(anio_escolar.id, seccion, fechaI, fechaF)      
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
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
