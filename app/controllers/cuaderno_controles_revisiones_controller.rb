class CuadernoControlesRevisionesController < ApplicationController
  
  # GET /cuaderno_controles_eventos
  # GET /cuaderno_controles_eventos.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_controles_revisiones = 
      CuadernoControlRevision.cerrado.se_revisan_por(PersonaVinculada.logueado(current_user.usuario).pluck("personas_vinculadas.id"))
        
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuaderno_controles_revisiones }
    end
  end

  # GET /cuaderno_controles_eventos/1
  # GET /cuaderno_controles_eventos/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control_revision = CuadernoControlRevision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control_revision }
    end
  end

  # GET /cuaderno_controles_eventos/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control_revision = CuadernoControlRevision.find(params[:id])
  end

  # GET /cuaderno_controles_eventos/new
  # GET /cuaderno_controles_eventos/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control_revision = CuadernoControlRevision.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control_revision }
    end
  end
  
  # PUT /cuaderno_controles_revisiones/1/revisar
  def revisar
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control_revision = CuadernoControlRevision.find(params[:id])
    
    revisor = PersonaVinculada.logueado(current_user.usuario).pluck("personas_vinculadas.id")
    observaciones = params[:cuaderno_control_revision][:observaciones]

    respond_to do |format|
      if @cuaderno_control_revision.update_attributes(:revisado => 1, :persona_vinculada_id => revisor, :observaciones => observaciones)
        format.html { redirect_to @cuaderno_control_revision, notice: 'Cuaderno de control revisado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @cuaderno_control_revision, notice: 'Cuaderno de control no fue revisado.' }
        format.json { render json: @cuaderno_control_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /cuaderno_controles_eventos
  # POST /cuaderno_controles_eventos.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control_revision = CuadernoControlRevision.new(params[:cuaderno_control_revision])
    
    respond_to do |format|
      if @cuaderno_control_revision.save
        format.html { redirect_to [@cuaderno_control_revision], notice: 'Revision agregada.' }
        format.json { render json: [@cuaderno_control_revision], status: :created, location: @cuaderno_control_revision }
      else
        format.html { render action: "new", alert: "Revision no fue agregada." }
        format.json { render json: @cuaderno_control_revision.errors, status: :unprocessable_entity }
      end
    end
  end
  
 
  # PUT /cuaderno_controles_eventos/1
  # PUT /cuaderno_controles_eventos/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    if @cuaderno_control_revision.update_attributes(params[:cuaderno_control_revision])
      flash[:notice] = "Revision actualizada."
      redirect_to [@cuaderno_control_revision]
    else
      flash[:alert] = "Revision no fue actualizada."
      render :action => "edit"
    end
  end
  

  # DELETE /cuaderno_controles_eventos/1
  # DELETE /cuaderno_controles_eventos/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control_revision = CuadernoControlRevision.find(params[:id])
    @cuaderno_control_revision.destroy    
    
    respond_to do |format|
      format.html { redirect_to @cuaderno_control }
      format.json { head :no_content }
    end
  end
end
