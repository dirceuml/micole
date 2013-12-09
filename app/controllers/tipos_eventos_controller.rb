class TiposEventosController < ApplicationController
  load_and_authorize_resource
  
  # GET /tipos_eventos
  # GET /tipos_eventos.json
  def index
    @tipos_eventos = TipoEvento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipos_eventos }
    end
  end

  # GET /tipos_eventos/1
  # GET /tipos_eventos/1.json
  def show
    @tipo_evento = TipoEvento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_evento }
    end
  end

  # GET /tipos_eventos/new
  # GET /tipos_eventos/new.json
  def new
    @tipo_evento = TipoEvento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_evento }
    end
  end

  # GET /tipos_eventos/1/edit
  def edit
    @tipo_evento = TipoEvento.find(params[:id])
  end

  # POST /tipos_eventos
  # POST /tipos_eventos.json
  def create
    @tipo_evento = TipoEvento.new(params[:tipo_evento])

    respond_to do |format|
      if @tipo_evento.save
        format.html { redirect_to @tipo_evento, notice: 'Tipo de evento fue creado satisfactoriamente' }
        format.json { render json: @tipo_evento, status: :created, location: @tipo_evento }
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipos_eventos/1
  # PUT /tipos_eventos/1.json
  def update
    @tipo_evento = TipoEvento.find(params[:id])

    respond_to do |format|
      if @tipo_evento.update_attributes(params[:tipo_evento])
        format.html { redirect_to @tipo_evento, notice: 'Tipo de evento fue actualizado satisfactoriamente' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_eventos/1
  # DELETE /tipos_eventos/1.json
  def destroy
    @tipo_evento = TipoEvento.find(params[:id])
    @tipo_evento.destroy

    respond_to do |format|
      format.html { redirect_to tipos_eventos_url }
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
