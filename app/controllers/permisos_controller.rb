class PermisosController < ApplicationController
  load_and_authorize_resource
  
  # GET /permisos
  # GET /permisos.json
  def index
    @permisos = Permiso.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @permisos }
    end
  end

  # GET /permisos/1
  # GET /permisos/1.json
  def show
    @permiso = Permiso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @permiso }
    end
  end

  # GET /permisos/new
  # GET /permisos/new.json
  def new
    @permiso = Permiso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @permiso }
    end
  end

  # GET /permisos/1/edit
  def edit
    @permiso = Permiso.find(params[:id])
  end

  # POST /permisos
  # POST /permisos.json
  def create
    @permiso = Permiso.new(params[:permiso])

    respond_to do |format|
      if @permiso.save
        format.html { redirect_to @permiso, notice: 'Permiso was successfully created.' }
        format.json { render json: @permiso, status: :created, location: @permiso }
      else
        format.html { render action: "new" }
        format.json { render json: @permiso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /permisos/1
  # PUT /permisos/1.json
  def update
    @permiso = Permiso.find(params[:id])

    respond_to do |format|
      if @permiso.update_attributes(params[:permiso])
        format.html { redirect_to @permiso, notice: 'Permiso was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @permiso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permisos/1
  # DELETE /permisos/1.json
  def destroy
    @permiso = Permiso.find(params[:id])
    @permiso.destroy

    respond_to do |format|
      format.html { redirect_to permisos_url }
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
