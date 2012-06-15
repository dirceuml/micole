class CuadernoControlSeccionsController < ApplicationController
  # GET /cuaderno_control_seccions
  # GET /cuaderno_control_seccions.json
  def index
    @cuaderno_control_seccions = CuadernoControlSeccion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuaderno_control_seccions }
    end
  end

  # GET /cuaderno_control_seccions/1
  # GET /cuaderno_control_seccions/1.json
  def show
    @cuaderno_control_seccion = CuadernoControlSeccion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control_seccion }
    end
  end

  # GET /cuaderno_control_seccions/new
  # GET /cuaderno_control_seccions/new.json
  def new
    @cuaderno_control_seccion = CuadernoControlSeccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control_seccion }
    end
  end

  # GET /cuaderno_control_seccions/1/edit
  def edit
    @cuaderno_control_seccion = CuadernoControlSeccion.find(params[:id])
  end

  # POST /cuaderno_control_seccions
  # POST /cuaderno_control_seccions.json
  def create
    @cuaderno_control_seccion = CuadernoControlSeccion.new(params[:cuaderno_control_seccion])

    respond_to do |format|
      if @cuaderno_control_seccion.save
        format.html { redirect_to @cuaderno_control_seccion, notice: 'Cuaderno control seccion was successfully created.' }
        format.json { render json: @cuaderno_control_seccion, status: :created, location: @cuaderno_control_seccion }
      else
        format.html { render action: "new" }
        format.json { render json: @cuaderno_control_seccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuaderno_control_seccions/1
  # PUT /cuaderno_control_seccions/1.json
  def update
    @cuaderno_control_seccion = CuadernoControlSeccion.find(params[:id])

    respond_to do |format|
      if @cuaderno_control_seccion.update_attributes(params[:cuaderno_control_seccion])
        format.html { redirect_to @cuaderno_control_seccion, notice: 'Cuaderno control seccion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuaderno_control_seccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuaderno_control_seccions/1
  # DELETE /cuaderno_control_seccions/1.json
  def destroy
    @cuaderno_control_seccion = CuadernoControlSeccion.find(params[:id])
    @cuaderno_control_seccion.destroy

    respond_to do |format|
      format.html { redirect_to cuaderno_control_seccions_url }
      format.json { head :no_content }
    end
  end
end
