class PersonaAutorizadaRecojosController < ApplicationController
  # GET /persona_autorizada_recojos
  # GET /persona_autorizada_recojos.json
  def index
    @persona_autorizada_recojos = PersonaAutorizadaRecojo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @persona_autorizada_recojos }
    end
  end

  # GET /persona_autorizada_recojos/1
  # GET /persona_autorizada_recojos/1.json
  def show
    @persona_autorizada_recojo = PersonaAutorizadaRecojo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @persona_autorizada_recojo }
    end
  end

  # GET /persona_autorizada_recojos/new
  # GET /persona_autorizada_recojos/new.json
  def new
    @persona_autorizada_recojo = PersonaAutorizadaRecojo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @persona_autorizada_recojo }
    end
  end

  # GET /persona_autorizada_recojos/1/edit
  def edit
    @persona_autorizada_recojo = PersonaAutorizadaRecojo.find(params[:id])
  end

  # POST /persona_autorizada_recojos
  # POST /persona_autorizada_recojos.json
  def create
    @persona_autorizada_recojo = PersonaAutorizadaRecojo.new(params[:persona_autorizada_recojo])

    respond_to do |format|
      if @persona_autorizada_recojo.save
        format.html { redirect_to @persona_autorizada_recojo, notice: 'Persona autorizada creada satisfactoriamente.' }
        format.json { render json: @persona_autorizada_recojo, status: :created, location: @persona_autorizada_recojo }
      else
        format.html { render action: "new" }
        format.json { render json: @persona_autorizada_recojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /persona_autorizada_recojos/1
  # PUT /persona_autorizada_recojos/1.json
  def update
    @persona_autorizada_recojo = PersonaAutorizadaRecojo.find(params[:id])

    respond_to do |format|
      if @persona_autorizada_recojo.update_attributes(params[:persona_autorizada_recojo])
        format.html { redirect_to @persona_autorizada_recojo, notice: 'Persona autorizada actualizada satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @persona_autorizada_recojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /persona_autorizada_recojos/1
  # DELETE /persona_autorizada_recojos/1.json
  def destroy
    @persona_autorizada_recojo = PersonaAutorizadaRecojo.find(params[:id])
    @persona_autorizada_recojo.destroy

    respond_to do |format|
      format.html { redirect_to persona_autorizada_recojos_url }
      format.json { head :no_content }
    end
  end
end
