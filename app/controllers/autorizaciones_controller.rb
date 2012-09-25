class AutorizacionesController < ApplicationController
  # GET /autorizaciones
  # GET /autorizaciones.json
  def index
    @autorizaciones = Autorizacion.order("respuesta")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @autorizaciones }
    end
  end
  
  def autorizacion
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @autorizaciones = Autorizacion.persona_autorizada(PersonaVinculada.logueado(params[:usuario]).pluck("personas_vinculadas.id"))
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @autorizaciones }
    end
  end  

  # GET /autorizaciones/1
  # GET /autorizaciones/1.json
  def show
    @autorizacion = Autorizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @autorizacion }
    end
  end

  # GET /autorizaciones/new
  # GET /autorizaciones/new.json
  def new
    @autorizacion = Autorizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @autorizacion }
    end
  end

  # GET /autorizaciones/1/edit
  def edit
    @autorizacion = Autorizacion.find(params[:id])
  end

  # POST /autorizaciones
  # POST /autorizaciones.json
  def create
    @autorizacion = Autorizacion.new(params[:autorizacion])

    respond_to do |format|
      if @autorizacion.save
        format.html { redirect_to @autorizacion, notice: 'Autorizacion was successfully created.' }
        format.json { render json: @autorizacion, status: :created, location: @autorizacion }
      else
        format.html { render action: "new" }
        format.json { render json: @autorizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /autorizaciones/1
  # PUT /autorizaciones/1.json
  def update
    @autorizacion = Autorizacion.find(params[:id])

    respond_to do |format|
      if @autorizacion.update_attributes(params[:autorizacion])
        format.html { redirect_to @autorizacion, notice: 'Autorizacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @autorizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /autorizaciones/1
  # DELETE /autorizaciones/1.json
  def destroy
    @autorizacion = Autorizacion.find(params[:id])
    @autorizacion.destroy

    respond_to do |format|
      format.html { redirect_to autorizaciones_url }
      format.json { head :no_content }
    end
  end
end
