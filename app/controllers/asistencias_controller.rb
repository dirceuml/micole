class AsistenciasController < ApplicationController
  # GET /asistencias
  # GET /asistencias.json
  def index
    @asistencias = Asistencia.all

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
end
