class PerfilesController < ApplicationController
  load_and_authorize_resource
  
  # GET /perfiles
  # GET /perfiles.json
  def index
    @perfiles = Perfil.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @perfiles }
    end
  end

  # GET /perfiles/1
  # GET /perfiles/1.json
  def show
    @perfil = Perfil.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @perfil }
    end
  end

  # GET /perfiles/new
  # GET /perfiles/new.json
  def new
    @perfil = Perfil.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @perfil }
    end
  end

  # GET /perfiles/1/edit
  def edit
    @perfil = Perfil.find(params[:id])
  end

  # POST /perfiles
  # POST /perfiles.json
  def create
    @perfil = Perfil.new(params[:perfil])

    respond_to do |format|
      if @perfil.save
        format.html { redirect_to perfiles_path, notice: 'el Perfil fue creado satisfactoriamente' }
        format.json { render json: @perfil, status: :created, location: @perfil }
      else
        format.html { render action: "new" }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /perfiles/1
  # PUT /perfiles/1.json
  def update
    @perfil = Perfil.find(params[:id])

    respond_to do |format|
      if @perfil.update_attributes(params[:perfil])
        format.html { redirect_to perfiles_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfiles/1
  # DELETE /perfiles/1.json
  def destroy
    @perfil = Perfil.find(params[:id])
    @perfil.destroy

    respond_to do |format|
      format.html { redirect_to perfiles_url }
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
