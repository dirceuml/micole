class ControlesAsistenciasController < ApplicationController
  load_and_authorize_resource  
  # GET /controles_asistencias
  # GET /controles_asistencias.json
  
  def index
    
    @controles_asistencias = ControlAsistencia.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @controles_asistencias }
    end
  end
  
  def grabar_inasistencias
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    if params[:alumno_id].nil?
      flash[:notice] = 'Seleccione a los alumnos ausentes'
      render :inasistencias
      return
    end
    
    ActiveRecord::Base.transaction do
      params[:alumno_id].each do |alumno|
        @controles_alumnos = ControlAsistencia.new(
          :anio_alumno_id => AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, alumno).id,
          :fecha => Date.current,
          :tipo_asistencia => 1,
          :usuario => current_user.usuario
        )
        
        if !@controles_alumnos.save
          flash[:notice] = 'Ocurrio un error al registrar las inasistencias'
          format.html { render action: "faltas" }
        else
          if @guardados.nil?
            @guardados = [@controles_alumnos.id]
          else
            @guardados.push(@controles_alumnos)
          end
          
          #@notificar = AlumnoPersonaVinculada.notificar_salida(alumno)
          #if !@notificar.empty?
          #  @notificar.each do |alumnopersona|
          #    if alumnopersona.persona_vinculada_id != params[:persona_vinculada_id]
          #      @persona = PersonaVinculada.find(alumnopersona.persona_vinculada_id)
          #      @alumno  = Alumno.find(alumno)
          #      AsistenciaMailer.delay.notificar_asistencia(2, @alumno, @asistencia_alumno_persona_vinculada, @persona)   ## Asincrono
          #    end
          #  end
          #end
        end
      end
    end
    flash[:notice] = 'Las inasistencias fueron registrados satisfactoriamente'
    redirect_to :controller => 'alumnos', :action => 'inasistencias', :seccion => params[:seccion_id]
  end
  
  
  def grabar_tardanzas
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    if params[:alumno_id].nil?
      flash[:notice] = 'Seleccione a los alumnos con tardanza'
      redirect_to :controller => 'alumnos', :action => 'tardanzas'
      return
    end
    
    ActiveRecord::Base.transaction do
      params[:alumno_id].each do |alumno|
        @controles_alumnos = ControlAsistencia.new(
          :anio_alumno_id => AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, alumno).id,
          :fecha => Date.current,
          :tipo_asistencia => 2,
          :usuario => current_user.usuario
        )
        
        if !@controles_alumnos.save
          flash[:notice] = 'Ocurrio un error al registrar las tardanzas'
          format.html { render action: "tardanzas" }
        else
          if @guardados.nil?
            @guardados = [@controles_alumnos.id]
          else
            @guardados.push(@controles_alumnos)
          end
          
          #@notificar = AlumnoPersonaVinculada.notificar_salida(alumno)
          #if !@notificar.empty?
          #  @notificar.each do |alumnopersona|
          #    if alumnopersona.persona_vinculada_id != params[:persona_vinculada_id]
          #      @persona = PersonaVinculada.find(alumnopersona.persona_vinculada_id)
          #      @alumno  = Alumno.find(alumno)
          #      AsistenciaMailer.delay.notificar_asistencia(2, @alumno, @asistencia_alumno_persona_vinculada, @persona)   ## Asincrono
          #    end
          #  end
          #end
        end
      end
    end
    flash[:notice] = 'Las tardanzas fueron registrados satisfactoriamente'
    redirect_to :controller => 'alumnos', :action => 'tardanzas'
  end  
  
  
  # GET /controles_asistencias/1
  # GET /controles_asistencias/1.json
  def show
    @control_asistencia = ControlAsistencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @control_asistencia }
    end
  end

  # GET /controles_asistencias/new
  # GET /controles_asistencias/new.json
  def new
    @control_asistencia = ControlAsistencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @control_asistencia }
    end
  end

  # GET /controles_asistencias/1/edit
  def edit
    @control_asistencia = ControlAsistencia.find(params[:id])
  end

  # POST /controles_asistencias
  # POST /controles_asistencias.json
  def create
    @control_asistencia = ControlAsistencia.new(params[:control_asistencia])

    respond_to do |format|
      if @control_asistencia.save
        format.html { redirect_to @control_asistencia, notice: 'Control asistencia was successfully created.' }
        format.json { render json: @control_asistencia, status: :created, location: @control_asistencia }
      else
        format.html { render action: "new" }
        format.json { render json: @control_asistencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /controles_asistencias/1
  # PUT /controles_asistencias/1.json
  def update
    @control_asistencia = ControlAsistencia.find(params[:id])

    respond_to do |format|
      if @control_asistencia.update_attributes(params[:control_asistencia])
        format.html { redirect_to @control_asistencia, notice: 'Control asistencia was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @control_asistencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controles_asistencias/1
  # DELETE /controles_asistencias/1.json
  def destroy
    @control_asistencia = ControlAsistencia.find(params[:id])
    @control_asistencia.destroy

    respond_to do |format|
      format.html { redirect_to controles_asistencias_url }
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
