class CuadernoControlesEventosController < ApplicationController
  # GET /cuaderno_controles_eventos
  # GET /cuaderno_controles_eventos.json
  def index
    @cuaderno_controles_eventos = CuadernoControlEvento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuaderno_controles_eventos }
    end
  end

  # GET /cuaderno_controles_eventos/1
  # GET /cuaderno_controles_eventos/1.json
  def show
    @cuaderno_control_evento = CuadernoControlEvento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control_evento }
    end
  end

  # GET /cuaderno_controles_eventos/new
  # GET /cuaderno_controles_eventos/new.json
  def new
    @cuaderno_control_evento = CuadernoControlEvento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control_evento }
    end
  end

  # GET /cuaderno_controles_eventos/1/edit
  def edit
    @cuaderno_control_evento = CuadernoControlEvento.find(params[:id])
  end

  # POST /cuaderno_controles_eventos
  # POST /cuaderno_controles_eventos.json
  def create
    @cuaderno_control_evento = CuadernoControlEvento.new(params[:cuaderno_control_evento])

    respond_to do |format|
      if @cuaderno_control_evento.save
        format.html { redirect_to @cuaderno_control_evento, notice: 'Cuaderno control evento was successfully created.' }
        format.json { render json: @cuaderno_control_evento, status: :created, location: @cuaderno_control_evento }
      else
        format.html { render action: "new" }
        format.json { render json: @cuaderno_control_evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuaderno_controles_eventos/1
  # PUT /cuaderno_controles_eventos/1.json
  def update
    @cuaderno_control_evento = CuadernoControlEvento.find(params[:id])

    respond_to do |format|
      if @cuaderno_control_evento.update_attributes(params[:cuaderno_control_evento])
        format.html { redirect_to @cuaderno_control_evento, notice: 'Cuaderno control evento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuaderno_control_evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuaderno_controles_eventos/1
  # DELETE /cuaderno_controles_eventos/1.json
  def destroy
    @cuaderno_control_evento = CuadernoControlEvento.find(params[:id])
    @cuaderno_control_evento.destroy

    respond_to do |format|
      format.html { redirect_to cuaderno_controles_eventos_url }
      format.json { head :no_content }
    end
  end
end
