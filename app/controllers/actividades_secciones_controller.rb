class ActividadesSeccionesController < ApplicationController
  # GET /actividades_secciones
  # GET /actividades_secciones.json
  def index
    @actividades_secciones = ActividadSeccion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actividades_secciones }
    end
  end

  # GET /actividades_secciones/1
  # GET /actividades_secciones/1.json
  def show
    @actividad_seccione = ActividadSeccion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actividad_seccione }
    end
  end

  # GET /actividades_secciones/new
  # GET /actividades_secciones/new.json
  def new
    @actividad_seccione = ActividadSeccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @actividad_seccione }
    end
  end

  # GET /actividades_secciones/1/edit
  def edit
    @actividad_seccione = ActividadSeccion.find(params[:id])
  end

  # POST /actividades_secciones
  # POST /actividades_secciones.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @actividad = Actividad.find(params[:actividad_id])
    @actividad_seccion = @actividad.actividades_secciones.create(params[:actividad_seccion])

    respond_to do |format|
      if @actividad_seccion.save
        format.html { redirect_to @actividad }
        format.json { render json: @actividad_seccione, status: :created, location: @actividad_seccione }
      else
        @actividad_seccion.seccion_id = ""
        format.html { render 'actividades/show' } 
      end
    end
  end

  # PUT /actividades_secciones/1
  # PUT /actividades_secciones/1.json
  def update
    @actividad_seccione = ActividadSeccion.find(params[:id])

    respond_to do |format|
      if @actividad_seccione.update_attributes(params[:actividad_seccione])
        format.html { redirect_to @actividad_seccione, notice: 'Actividad seccion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @actividad_seccione.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actividades_secciones/1
  # DELETE /actividades_secciones/1.json
  def destroy
    @actividad_seccione = ActividadSeccion.find(params[:id])
    @actividad_seccione.destroy

    respond_to do |format|
      format.html { redirect_to actividades_secciones_url }
      format.json { head :no_content }
    end
  end
end
