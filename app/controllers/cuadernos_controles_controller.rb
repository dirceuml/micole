class CuadernosControlesController < ApplicationController
  # GET /cuadernos_controles
  # GET /cuadernos_controles.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuadernos_controles = CuadernoControl.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuadernos_controles }
    end
  end

  # GET /cuadernos_controles/1
  # GET /cuadernos_controles/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control }
    end
  end

  # GET /cuadernos_controles/new
  # GET /cuadernos_controles/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control }
    end
  end

  # GET /cuadernos_controles/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])
  end

  # POST /cuadernos_controles
  # POST /cuadernos_controles.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.new(params[:cuaderno_control])

    respond_to do |format|
      if @cuaderno_control.save
        format.html { redirect_to @cuaderno_control, notice: 'Cuaderno control was successfully created.' }
        format.json { render json: @cuaderno_control, status: :created, location: @cuaderno_control }
      else
        format.html { render action: "new" }
        format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuadernos_controles/1
  # PUT /cuadernos_controles/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])

    respond_to do |format|
      if @cuaderno_control.update_attributes(params[:cuaderno_control])
        format.html { redirect_to @cuaderno_control, notice: 'Cuaderno control was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuadernos_controles/1
  # DELETE /cuadernos_controles/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])
    @cuaderno_control.destroy

    respond_to do |format|
      format.html { redirect_to cuadernos_controles_url }
      format.json { head :no_content }
    end
  end
end
