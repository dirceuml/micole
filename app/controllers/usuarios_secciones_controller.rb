class UsuariosSeccionesController < ApplicationController
  load_and_authorize_resource
  # GET /usuarios_secciones
  # GET /usuarios_secciones.json
  def index
    @usuarios_secciones = UsuarioSeccion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usuarios_secciones }
    end
  end

  # GET /usuarios_secciones/1
  # GET /usuarios_secciones/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @usuario_seccion = UsuarioSeccion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usuario_seccion }
    end
  end

  # GET /usuarios_secciones/new
  # GET /usuarios_secciones/new.json
  def new
    @usuario_seccion = UsuarioSeccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario_seccion }
    end
  end

  # GET /usuarios_secciones/1/edit
  def edit
    @usuario_seccion = UsuarioSeccion.find(params[:id])
  end

  # POST /usuarios_secciones
  # POST /usuarios_secciones.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @usuario = Usuario.find(params[:usuario_id])
    @usuario_seccion = @usuario.usuarios_secciones.create(params[:usuario_seccion])
    

    respond_to do |format|
      if @usuario_seccion.save
        format.html { redirect_to @usuario }
        format.json { render json: @usuario_seccion, status: :created, location: @usuario_seccion }
      else
        @usuario_seccion.seccion_id = ""
        format.html { render 'usuarios/show' }
        format.json { render json: @usuario_seccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios_secciones/1
  # PUT /usuarios_secciones/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @usuario_seccion = UsuarioSeccion.find(params[:id])

    respond_to do |format|
      if @usuario_seccion.update_attributes(params[:usuario_seccion])
        format.html { redirect_to @usuario_seccion, notice: 'Usuario seccion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usuario_seccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios_secciones/1
  # DELETE /usuarios_secciones/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @usuario = Usuario.find(params[:usuario_id])
    @usuario_seccion = @usuario.usuarios_secciones.find(params[:id])
    @usuario_seccion.destroy
    
    redirect_to usuario_path(@usuario)
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to menu_url, :alert => exception.message
    end
  end
end
