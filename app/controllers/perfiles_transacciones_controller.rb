class PerfilesTransaccionesController < ApplicationController
  load_and_authorize_resource
  
  # GET /perfiles_transacciones
  # GET /perfiles_transacciones.json
  def index
    @perfiles_transacciones = PerfilTransaccion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @perfiles_transacciones }
    end
  end

  # GET /perfiles_transacciones/1
  # GET /perfiles_transacciones/1.json
  def show
    @perfil_transaccione = PerfilTransaccion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @perfil_transaccione }
    end
  end

  # GET /perfiles_transacciones/new
  # GET /perfiles_transacciones/new.json
  def new
    @perfil_transaccione = PerfilTransaccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @perfil_transaccione }
    end
  end

  # GET /perfiles_transacciones/1/edit
  def edit
    @perfil_transaccione = PerfilTransaccion.find(params[:id])
  end

  # POST /perfiles_transacciones
  # POST /perfiles_transacciones.json
  def create
    @perfil_transaccione = PerfilTransaccion.new(params[:perfil_transaccione])

    respond_to do |format|
      if @perfil_transaccione.save
        format.html { redirect_to @perfil_transaccione, notice: 'Perfil transaccion was successfully created.' }
        format.json { render json: @perfil_transaccione, status: :created, location: @perfil_transaccione }
      else
        format.html { render action: "new" }
        format.json { render json: @perfil_transaccione.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /perfiles_transacciones/1
  # PUT /perfiles_transacciones/1.json
  def update
    @perfil_transaccione = PerfilTransaccion.find(params[:id])

    respond_to do |format|
      if @perfil_transaccione.update_attributes(params[:perfil_transaccione])
        format.html { redirect_to @perfil_transaccione, notice: 'Perfil transaccion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @perfil_transaccione.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfiles_transacciones/1
  # DELETE /perfiles_transacciones/1.json
  def destroy
    @perfil_transaccione = PerfilTransaccion.find(params[:id])
    @perfil_transaccione.destroy

    respond_to do |format|
      format.html { redirect_to perfiles_transacciones_url }
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
