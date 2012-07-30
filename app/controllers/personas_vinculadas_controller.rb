class PersonasVinculadasController < ApplicationController
  # GET /personas_vinculadas
  # GET /personas_vinculadas.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @personas_vinculadas = PersonaVinculada.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @personas_vinculadas }
    end
  end

  # GET /personas_vinculadas/1
  # GET /personas_vinculadas/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @persona_vinculada }
    end
  end

  # GET /personas_vinculadas/new
  # GET /personas_vinculadas/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @persona_vinculada }
    end
  end

  # GET /personas_vinculadas/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:id])
  end

  # POST /personas_vinculadas
  # POST /personas_vinculadas.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.new(params[:persona_vinculada])

    respond_to do |format|
      if @persona_vinculada.save
        format.html { redirect_to @persona_vinculada, notice: 'Persona vinculada was successfully created.' }
        format.json { render json: @persona_vinculada, status: :created, location: @persona_vinculada }
      else
        format.html { render action: "new" }
        format.json { render json: @persona_vinculada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /personas_vinculadas/1
  # PUT /personas_vinculadas/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:id])

    respond_to do |format|
      if @persona_vinculada.update_attributes(params[:persona_vinculada])
        format.html { redirect_to @persona_vinculada, notice: 'Persona vinculada was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @persona_vinculada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas_vinculadas/1
  # DELETE /personas_vinculadas/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:id])
    @persona_vinculada.destroy

    respond_to do |format|
      format.html { redirect_to personas_vinculadas_url }
      format.json { head :no_content }
    end
  end
end
