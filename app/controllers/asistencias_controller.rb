class AsistenciasController < ApplicationController
  load_and_authorize_resource
  # GET /asistencias
  # GET /asistencias.json
  def index
#    @asistencias = Asistencia.all
    seccion = params[:seccion_id]
    if params[:seccion_id].nil?
      fecha = Date.current
    else
      fecha = params[:fecha].to_date
    end
    
#    @asistencias = Asistencia.por_seccion_fecha(seccion, fecha).movimiento(2)
    @asistencias = Asistencia.por_seccion_fecha(seccion, fecha).salida

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asistencias }
    end
  end
  
  
  def consultar
    seccion = params[:seccion_id]
    if params[:seccion_id].nil?
      fechaI = Date.current
      fechaF = Date.current
    else
      fechaI = params[:fechaI].to_date
      fechaF = params[:fechaF].to_date
    end
    
#    @asistencias = Asistencia.por_seccion_fecha(seccion, fecha).movimiento(2)
    @asistencias = Asistencia.por_seccion_fecha(seccion, fecha).salida

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asistencias }
    end
  end  
  
  # GET /asistencias/1
  # GET /asistencias/1.json
  def show
    @asistencia = Asistencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asistencia }
    end
  end

  # GET /asistencias/new
  # GET /asistencias/new.json
  def new
    @asistencia = Asistencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asistencia }
    end
  end

  # GET /asistencias/1/edit
  def edit
    @asistencia = Asistencia.find(params[:id])
  end

  # POST /asistencias
  # POST /asistencias.json
  def create
    @asistencia = Asistencia.new(params[:asistencia])

    respond_to do |format|
      if @asistencia.save
        format.html { redirect_to @asistencia, notice: 'Asistencia was successfully created.' }
        format.json { render json: @asistencia, status: :created, location: @asistencia }
      else
        format.html { render action: "new" }
        format.json { render json: @asistencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /crear_en_bloque
  # POST /crear_en_bloque.json
  def crear_en_bloque
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    ActiveRecord::Base.transaction do
      params[:alumno_id].each do |alumno|   
        @asistencia_alumno_persona_vinculada = Asistencia.new(
          :anio_alumno_id => AnioAlumno.find_by_anio_escolar_id_and_alumno_id(1, alumno).id,
          :fecha_hora => Time.now,
          :persona_vinculada_id => params[:persona_vinculada_id],
          :usuario => current_user.usuario,
          :tipo_movimiento => 2
        )

        if !@asistencia_alumno_persona_vinculada.save
          flash[:notice] = 'Ocurrio un error al registrar la salida'
          format.html { render action: "consultar" }
        else
          if @guardados.nil?
            @guardados = [@asistencia_alumno_persona_vinculada.id]
          else
            @guardados.push(@asistencia_alumno_persona_vinculada)
          end
        end
      end
    end

    tipo = PersonaVinculada.find(params[:persona_vinculada_id]).tipo_documento
    numero = PersonaVinculada.find(params[:persona_vinculada_id]).numero_documento
    redirect_to :controller => 'alumnos_personas_vinculadas', :action => 'consultar',
      :tipo_documento => tipo, :numero_documento => numero
  end

  # PUT /asistencias/1
  # PUT /asistencias/1.json
  def update
    @asistencia = Asistencia.find(params[:id])

    respond_to do |format|
      if @asistencia.update_attributes(params[:asistencia])
        format.html { redirect_to @asistencia, notice: 'Asistencia was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asistencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asistencias/1
  # DELETE /asistencias/1.json
  def destroy
    @asistencia = Asistencia.find(params[:id])
    @asistencia.destroy

    respond_to do |format|
      format.html { redirect_to asistencias_url }
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
