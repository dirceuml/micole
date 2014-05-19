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
    
    @asistencias = Asistencia.por_seccion_fecha(anio_escolar.id, seccion, fecha).salida

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asistencias }
    end
  end
  
  def registrar
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    if params[:codigo_alumno].nil?
      codigo = 0
    else
      codigo = params[:codigo_alumno].to_i
    end
    
    @asistencias = Asistencia.por_alumno_fecha(anio_escolar.id, codigo, Date.current)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
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
    

    @asistencias = Asistencia.por_seccion_rango_fechas(anio_escolar.id, seccion, fechaI, fechaF)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asistencias }
    end
  end  
  
  def consultar_alumno
    alumno = params[:alumno_id]
    if params[:alumno_id].nil?
      fechaI = Date.current
      fechaF = Date.current
    else
      fechaI = params[:fechaI].to_date
      fechaF = params[:fechaF].to_date
    end
    
    @asistencias = Asistencia.por_alumno_rango_fechas(anio_escolar.id, alumno, fechaI, fechaF).order("fecha_hora", "tipo_movimiento")
    
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
#    @asistencia = Asistencia.new

    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    if params[:codigo_alumno].nil?
      codigo = 0
    else
      codigo = params[:codigo_alumno].to_i
    end
    
    @asistencias = Asistencia.por_alumno_fecha(anio_escolar.id, codigo, Date.current)
    @personasvinculadas = PersonaVinculada.vinculados_de(0)
    @nuevo = 1
    
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
    codigo = params[:codigo_alumno].to_i
    personavinculada = params[:asistencia][:persona_vinculada_id].to_i
    if codigo == 0
      flash[:notice] = 'Ingrese el codigo del alumno'
      render :new
    else
      if !AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, codigo)
        flash[:notice] = "El codigo #{codigo} no existe"
        redirect_to(:new_asistencia) and return
      end
      
      @asistencias = Asistencia.por_alumno_fecha(anio_escolar.id, codigo, Date.current)
      
      ingreso = 0
      fecha_hora = Time.now
      salida  = 0
      @asistencias.each do |asistencia|
        if asistencia.tipo_movimiento == 1
          ingreso = 1
          fecha_hora = asistencia.fecha_hora
        end
        if asistencia.tipo_movimiento == 2
          salida = 1
        end
      end
      movimiento = 0
      if ingreso == 0 && salida  == 0
        movimiento = 1
      end
      if ingreso == 1 && salida  == 0
        if (Time.now- fecha_hora) > 60
          movimiento = 2
        end
      end
      
      if movimiento == 2
        if Alumno.find(codigo).salida_con_persona == 1
          cargarpersonasvinculadas = 0
          if personavinculada == 0
            if @personasvinculadas.nil?
              cargarpersonasvinculadas = 1
            else
              cargarpersonasvinculadas = 1
            end
          else
            if AlumnoPersonaVinculada.find_by_alumno_id_and_persona_vinculada_id(codigo, personavinculada).nil?
              cargarpersonasvinculadas = 1
            end
          end
          if cargarpersonasvinculadas == 1
            @personasvinculadas = PersonaVinculada.vinculados_de(codigo)
            flash[:notice] = 'Seleccione la persona que recoge al alumno'
            @nuevo = 0
            render :new
            return
          end
        end
      end
      
      if movimiento == 0
        if salida  == 0
          flash[:notice] = 'Ha intentado registrar dos veces el ingreso'
        else
          flash[:notice] = 'Ha intentado registrar dos veces la salida'
        end
        render :new
        @nuevo = 1
      else
        if personavinculada == 0
          personavinculada = nil
        end
        @asistencia = Asistencia.new(
            :anio_alumno_id => AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, codigo).id,
            :fecha_hora => Time.now,
            :usuario => current_user.usuario,
            :persona_vinculada_id => personavinculada,
            :tipo_movimiento => movimiento
        )
        if !@asistencia.save
          flash[:notice] = 'Ocurrio un error al registrar la asistencia'
          format.html { render action: "new" }
        else
          if @guardados.nil?
            @guardados = [@asistencia.id]
          else
            @guardados.push(@asistencia)
          end
          
          if movimiento == 1
            @notificar = AlumnoPersonaVinculada.notificar_ingreso(codigo)
          else
            @notificar = AlumnoPersonaVinculada.notificar_salida(codigo)
          end
          if !@notificar.empty?
            @notificar.each do |alumnopersona|
              @persona = PersonaVinculada.find(alumnopersona.persona_vinculada_id)
              @alumno  = Alumno.find(codigo)
              AsistenciaMailer.delay.notificar_asistencia(movimiento, @alumno, @asistencia, @persona)   ## Asincrono
            end
          end
        end
        redirect_to :controller => 'asistencias', :action => 'new' , :codigo_alumno => codigo
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
          :anio_alumno_id => AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, alumno).id,
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
          
          @notificar = AlumnoPersonaVinculada.notificar_salida(alumno)
          if !@notificar.empty?
            @notificar.each do |alumnopersona|
              if alumnopersona.persona_vinculada_id != params[:persona_vinculada_id]
                @persona = PersonaVinculada.find(alumnopersona.persona_vinculada_id)
                @alumno  = Alumno.find(alumno)
                AsistenciaMailer.delay.notificar_asistencia(2, @alumno, @asistencia_alumno_persona_vinculada, @persona)   ## Asincrono
              end
            end
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
#      format.html { redirect_to asistencias_url }
      format.html { redirect_to new_asistencia_path }
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
