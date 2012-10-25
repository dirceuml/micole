class SeccionesController < ApplicationController
  load_and_authorize_resource
  
  # GET /secciones
  # GET /secciones.json
  def index
    @secciones = Seccion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @secciones }
    end
  end

  # GET /secciones/1
  # GET /secciones/1.json
  def show
    @seccion = Seccion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @seccion }
    end
  end

  # GET /secciones/new
  # GET /secciones/new.json
  def new
    @seccion = Seccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @seccion }
    end
  end

  # GET /secciones/1/edit
  def edit
    @seccion = Seccion.find(params[:id])
  end

  # POST /secciones
  # POST /secciones.json
  def create
    @seccion = Seccion.new(params[:seccion])

    respond_to do |format|
      if @seccion.save
        format.html { redirect_to @seccion, notice: 'Seccion was successfully created.' }
        format.json { render json: @seccion, status: :created, location: @seccion }
      else
        format.html { render action: "new" }
        format.json { render json: @seccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /secciones/1
  # PUT /secciones/1.json
  def update
    @seccion = Seccion.find(params[:id])

    respond_to do |format|
      if @seccion.update_attributes(params[:seccion])
        format.html { redirect_to @seccion, notice: 'Seccion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @seccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secciones/1
  # DELETE /secciones/1.json
  def destroy
    @seccion = Seccion.find(params[:id])
    @seccion.destroy

    respond_to do |format|
      format.html { redirect_to secciones_url }
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
