class CuadernoControlesRevisionesController < ApplicationController
  load_and_authorize_resource
  
  # GET /cuaderno_controles_eventos
  # GET /cuaderno_controles_eventos.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    if current_user.perfil_id == 4   # Es un alumno
      alumno  = Alumno.find(current_user.alumno_id).id
      @cuaderno_controles_revisiones = CuadernoControlRevision.cerrado(anio_escolar.id).se_consultan_por(alumno).order("cuadernos_controles.fecha DESC")      
    else
      if params[:accion].nil? || params[:accion] == "verificar"
        seccion = params[:seccion_id]
        if params[:seccion_id].nil?
          fecha = Date.current
        else
          fecha = params[:fecha].to_date
        end    
        
        @cuaderno_controles_revisiones = CuadernoControlRevision.verificar(seccion, fecha)
      else
        if params[:accion] == "revisar"
          @cuaderno_controles_revisiones = CuadernoControlRevision.cerrado(anio_escolar.id).se_revisan_por(PersonaVinculada.logueado(params[:usuario]).pluck("personas_vinculadas.id")).order("cuadernos_controles.fecha DESC")
        end
      end
    end
     
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
    
    if current_user.clave_hash != BCrypt::Engine.hash_secret(params[:clave], current_user.clave_salt) then
      flash[:alert] = "Clave incorrecta."
      redirect_to [@cuaderno_control_revision] and return
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
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to menu_url, :alert => exception.message
    end
  end
end
