class CuadernoControlsController < ApplicationController
  # GET /cuaderno_controls
  # GET /cuaderno_controls.json
  def index
    @cuaderno_controls = CuadernoControl.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuaderno_controls }
    end
  end

  # GET /cuaderno_controls/1
  # GET /cuaderno_controls/1.json
  def show
    @cuaderno_control = CuadernoControl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control }
    end
  end

  # GET /cuaderno_controls/new
  # GET /cuaderno_controls/new.json
  def new
    @cuaderno_control = CuadernoControl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control }
    end
  end

  # GET /cuaderno_controls/1/edit
  def edit
    @cuaderno_control = CuadernoControl.find(params[:id])
  end

  # POST /cuaderno_controls
  # POST /cuaderno_controls.json
  def create
    @cuaderno_control = CuadernoControl.new(params[:cuaderno_control])

    respond_to do |format|
      if @cuaderno_control.save
        format.html { redirect_to @cuaderno_control, notice: 'Cuaderno de control creado satisfactoriamente.' }
        format.json { render json: @cuaderno_control, status: :created, location: @cuaderno_control }
      else
        format.html { render action: "new" }
        format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuaderno_controls/1
  # PUT /cuaderno_controls/1.json
  def update
    @cuaderno_control = CuadernoControl.find(params[:id])

    respond_to do |format|
      if @cuaderno_control.update_attributes(params[:cuaderno_control])
        format.html { redirect_to @cuaderno_control, notice: 'Cuaderno de control actualizado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuaderno_controls/1
  # DELETE /cuaderno_controls/1.json
  def destroy
    @cuaderno_control = CuadernoControl.find(params[:id])
    @cuaderno_control.destroy

    respond_to do |format|
      format.html { redirect_to cuaderno_controls_url }
      format.json { head :no_content }
    end
  end
end
