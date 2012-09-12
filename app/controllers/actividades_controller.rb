class ActividadesController < ApplicationController
  # GET /actividades
  # GET /actividades.json
  def index
    @actividades = Actividad.all

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
        format.html { redirect_to @actividad, notice: 'Actividad was successfully created.' }
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
    @actividad = Actividad.find(params[:id])

    respond_to do |format|
      if @actividad.update_attributes(params[:actividad])
        format.html { redirect_to @actividad, notice: 'Actividad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @actividad.errors, status: :unprocessable_entity }
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
end
