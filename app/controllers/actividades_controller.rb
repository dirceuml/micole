class ActividadesController < ApplicationController
  load_and_authorize_resource
  # GET /actividades
  # GET /actividades.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    if params[:fecha].nil?
      @actividades = Actividad.order("fecha_hora_inicio")      
    else
      if params[:persona].nil?
        @actividades = Actividad.por_fecha_inicio(Date.strptime(params[:fecha], '%d/%m/%Y'))
      else
        @actividades = Actividad.por_persona_y_fecha(params[:persona], Date.strptime(params[:fecha], '%d/%m/%Y'))
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actividades }
    end
  end

  # GET /calendario
  # GET /calendario.json
  def calendario
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @actividades = Actividad.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actividades }
    end
  end

  # GET /actividades/1
  # GET /actividades/1.json
  def show
    @actividad = Actividad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actividad }
    end
  end

  # GET /actividades/new
  # GET /actividades/new.json
  def new
    @actividad = Actividad.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @actividad }
    end
  end

  # GET /actividades/1/edit
  def edit
    @actividad = Actividad.find(params[:id])
  end

  # POST /actividades
  # POST /actividades.json
  def create
    @actividad = Actividad.new(params[:actividad])

    respond_to do |format|
      if @actividad.save
        format.html { redirect_to @actividad, notice: 'Actividad fue creado satisfactoriamente.' }
        format.json { render json: @actividad, status: :created, location: @actividad }
      else
        format.html { render action: "new" }
        format.json { render json: @actividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /actividades/1
  # PUT /actividades/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @actividad = Actividad.find(params[:id])
    estado_anterior = @actividad.estado
    
    ActiveRecord::Base.transaction do
    respond_to do |format|
      if @actividad.update_attributes(params[:actividad])
        if @actividad.estado == 2 and estado_anterior == 1 and @actividad.requiere_autorizacion == 1 
          sql = '
            Insert Into autorizaciones (actividad_id, alumno_id, usuario, created_at, updated_at)
            (Select s.actividad_id, a.alumno_id, \'' + current_user.usuario + '\', current_date, current_date
            From actividades_secciones s, anios_alumnos a
            Where s.actividad_id = ' + params[:id].to_s + '
              And s.seccion_id = a.seccion_id)
            Returning id'        

          if Autorizacion.connection.insert(sql)
            #envío de solicitud de autorización
            @actividad.enviar_solicitud_autorizacion
          
            format.html { redirect_to @actividad, notice: 'Actividad fue actualizada satisfactoriamente.' }
            format.json { head :no_content }
          else
            format.html { redirect_to @actividad, notice: 'Actividad no fue actualizada.' } #OJO
            format.json { render json: @actividad.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to @actividad, notice: 'Actividad fue actualizada satisfactoriamente.' }
          format.json { head :no_content }
        end
      else
        format.html { redirect_to @actividad, notice: 'Actividad no fue actualizada.' }
        format.json { render json: @actividad.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /actividades/1
  # DELETE /actividades/1.json
  def destroy
    @actividad = Actividad.find(params[:id])
    @actividad.destroy

    respond_to do |format|
      format.html { redirect_to actividades_url }
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
