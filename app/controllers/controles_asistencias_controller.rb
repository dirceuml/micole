class ControlesAsistenciasController < ApplicationController
  # GET /controles_asistencias
  # GET /controles_asistencias.json
  def index
    @controles_asistencias = ControlAsistencia.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @controles_asistencias }
    end
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
end
