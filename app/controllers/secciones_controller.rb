class SeccionesController < ApplicationController
  load_and_authorize_resource
  
  before_filter :find_grado, :except => [:index]
  
  before_filter :find_seccion, :only => [:show,
                                          :edit,
                                          :update,
                                          :destroy]  
  
  # GET /secciones
  # GET /secciones.json
  def index
    @secciones = Seccion.order("grado_id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @secciones }
    end
  end

  # GET /secciones/1
  # GET /secciones/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end    
    #@seccion = Seccion.find(params[:id])
    
    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @seccion }
    #end
  end

  # GET /secciones/new
  # GET /secciones/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end    
    #@seccion = Seccion.new
    @seccion = @grado.secciones.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @seccion }
    end
  end

  # GET /secciones/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end    
    #@seccion = Seccion.find(params[:id])
  end

  # POST /secciones
  # POST /secciones.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    #@seccion = Seccion.new(params[:seccion])
    @seccion = @grado.secciones.build(params[:seccion])
    
    if @seccion.save
      redirect_to @grado # grados#show
    else
      flash[:alert] = "Seccion no fue agregado."
      render :action => "new"
    end
    
    #respond_to do |format|
    #  if @seccion.save
    #    format.html { redirect_to @seccion, notice: 'La seccion fue creado satisfactoriamente.' }
    #    format.json { render json: @seccion, status: :created, location: @seccion }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @seccion.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /secciones/1
  # PUT /secciones/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    if @seccion.update_attributes(params[:seccion])
      flash[:notice] = "Seccion actualizado."
      redirect_to [@grado, @seccion]
    else
      flash[:alert] = "Seccion no fue actualizado."
      render :action => "edit"
    end
    
    #@seccion = Seccion.find(params[:id])
    
    #respond_to do |format|
    #  if @seccion.update_attributes(params[:seccion])
    #    format.html { redirect_to @seccion, notice: 'La seccion fue actualizado satisfactoriamente.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @seccion.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /secciones/1
  # DELETE /secciones/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    #@seccion = Seccion.find(params[:id])
    @seccion.destroy
    
    redirect_to @grado

    #respond_to do |format|
    #  format.html { redirect_to secciones_url }
    #  format.json { head :no_content }
    #end
  end
  
  private
    def find_grado
      @grado = Grado.find(params[:grado_id])
    end
    
    def find_seccion
      @seccion = @grado.secciones.find(params[:id])
    end
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to menu_url, :alert => exception.message
    end
  end
end
