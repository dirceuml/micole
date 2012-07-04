class CuadernoControlesRevisionesController < ApplicationController
  # GET /cuaderno_controles_revisiones
  # GET /cuaderno_controles_revisiones.json
  def index
    @cuaderno_controles_revisiones = CuadernoControlRevision.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuaderno_controles_revisiones }
    end
  end

  # GET /cuaderno_controles_revisiones/1
  # GET /cuaderno_controles_revisiones/1.json
  def show
    @cuaderno_control_revisione = CuadernoControlRevision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control_revisione }
    end
  end

  # GET /cuaderno_controles_revisiones/new
  # GET /cuaderno_controles_revisiones/new.json
  def new
    @cuaderno_control_revisione = CuadernoControlRevision.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control_revisione }
    end
  end

  # GET /cuaderno_controles_revisiones/1/edit
  def edit
    @cuaderno_control_revisione = CuadernoControlRevision.find(params[:id])
  end

  # POST /cuaderno_controles_revisiones
  # POST /cuaderno_controles_revisiones.json
  def create
    @cuaderno_control_revisione = CuadernoControlRevision.new(params[:cuaderno_control_revisione])

    respond_to do |format|
      if @cuaderno_control_revisione.save
        format.html { redirect_to @cuaderno_control_revisione, notice: 'Cuaderno control revision was successfully created.' }
        format.json { render json: @cuaderno_control_revisione, status: :created, location: @cuaderno_control_revisione }
      else
        format.html { render action: "new" }
        format.json { render json: @cuaderno_control_revisione.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuaderno_controles_revisiones/1
  # PUT /cuaderno_controles_revisiones/1.json
  def update
    @cuaderno_control_revisione = CuadernoControlRevision.find(params[:id])

    respond_to do |format|
      if @cuaderno_control_revisione.update_attributes(params[:cuaderno_control_revisione])
        format.html { redirect_to @cuaderno_control_revisione, notice: 'Cuaderno control revision was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuaderno_control_revisione.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuaderno_controles_revisiones/1
  # DELETE /cuaderno_controles_revisiones/1.json
  def destroy
    @cuaderno_control_revisione = CuadernoControlRevision.find(params[:id])
    @cuaderno_control_revisione.destroy

    respond_to do |format|
      format.html { redirect_to cuaderno_controles_revisiones_url }
      format.json { head :no_content }
    end
  end
end
