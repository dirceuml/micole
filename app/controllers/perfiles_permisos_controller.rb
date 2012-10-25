class PerfilesPermisosController < ApplicationController
  # GET /perfiles_permisos
  # GET /perfiles_permisos.json
  def index
    @perfiles_permisos = PerfilPermiso.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @perfiles_permisos }
    end
  end

  # GET /perfiles_permisos/1
  # GET /perfiles_permisos/1.json
  def show
    @perfil_permiso = PerfilPermiso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @perfil_permiso }
    end
  end

  # GET /perfiles_permisos/new
  # GET /perfiles_permisos/new.json
  def new
    @perfil_permiso = PerfilPermiso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @perfil_permiso }
    end
  end

  # GET /perfiles_permisos/1/edit
  def edit
    @perfil_permiso = PerfilPermiso.find(params[:id])
  end

  # POST /perfiles_permisos
  # POST /perfiles_permisos.json
  def create
    @perfil_permiso = PerfilPermiso.new(params[:perfil_permiso])

    respond_to do |format|
      if @perfil_permiso.save
        format.html { redirect_to @perfil_permiso, notice: 'Perfil permiso was successfully created.' }
        format.json { render json: @perfil_permiso, status: :created, location: @perfil_permiso }
      else
        format.html { render action: "new" }
        format.json { render json: @perfil_permiso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /perfiles_permisos/1
  # PUT /perfiles_permisos/1.json
  def update
    @perfil_permiso = PerfilPermiso.find(params[:id])

    respond_to do |format|
      if @perfil_permiso.update_attributes(params[:perfil_permiso])
        format.html { redirect_to @perfil_permiso, notice: 'Perfil permiso was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @perfil_permiso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfiles_permisos/1
  # DELETE /perfiles_permisos/1.json
  def destroy
    @perfil_permiso = PerfilPermiso.find(params[:id])
    @perfil_permiso.destroy

    respond_to do |format|
      format.html { redirect_to perfiles_permisos_url }
      format.json { head :no_content }
    end
  end
end
