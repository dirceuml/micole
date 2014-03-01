class GradosController < ApplicationController
  load_and_authorize_resource
  
  # GET /grados
  # GET /grados.json
  def index
    @grados = Grado.order("grado")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grados }
    end
  end

  # GET /grados/1
  # GET /grados/1.json
  def show
    @grado = Grado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grado }
    end
  end

  # GET /grados/new
  # GET /grados/new.json
  def new
    @grado = Grado.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grado }
    end
  end

  # GET /grados/1/edit
  def edit
    @grado = Grado.find(params[:id])
  end

  # POST /grados
  # POST /grados.json
  def create
    @grado = Grado.new(params[:grado])

    respond_to do |format|
      if @grado.save
        format.html { redirect_to @grado, notice: 'El grado fue creado satisfactoriamente.' }
        format.json { render json: @grado, status: :created, location: @grado }
      else
        format.html { render action: "new" }
        format.json { render json: @grado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /grados/1
  # PUT /grados/1.json
  def update
    @grado = Grado.find(params[:id])

    respond_to do |format|
      if @grado.update_attributes(params[:grado])
        format.html { redirect_to @grado, notice: 'El grado fue actualizado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @grado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grados/1
  # DELETE /grados/1.json
  def destroy
    @grado = Grado.find(params[:id])
    @grado.destroy

    respond_to do |format|
      format.html { redirect_to grados_url }
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
