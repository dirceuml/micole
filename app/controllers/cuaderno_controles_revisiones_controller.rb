class CuadernoControlesRevisionesController < ApplicationController
  before_filter :find_alumno
  
  before_filter :find_cuaderno_control_revision, :only => [:show,
                                                          :edit,
                                                          :update,
                                                          :destroy]

  # GET /cuaderno_controles_eventos
  # GET /cuaderno_controles_eventos.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    sql = "Select r.*
      From cuaderno_controles_revisiones r, cuadernos_controles c, alumnos_personas_vinculadas p, usuarios u
      Where c.estado = 2
        And u.usuario = '" + current_user.usuario + "'
        And p.persona_vinculada_id = u.persona_vinculada_id
        And r.cuaderno_control_id = c.id
        And r.alumno_id = p.alumno_id"
    
    #@cuaderno_controles_revisiones = CuadernoControlRevision.all :joins => :cuaderno_control, :conditions => { :cuadernos_controles => {:estado => 2}}
    
    @cuaderno_controles_revisiones = CuadernoControlRevision.find_by_sql(sql)
    
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

    #    @cuaderno_control_revision = CuadernoControlEvento.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @cuaderno_control_revision }
#    end
  end

  # GET /cuaderno_controles_eventos/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    #@cuaderno_control_revision = CuadernoControlEvento.find(params[:id])
  end
  
 
  # PUT /cuaderno_controles_eventos/1
  # PUT /cuaderno_controles_eventos/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    if @cuaderno_control_revision.update_attributes(params[:cuaderno_control_revision])
      flash[:notice] = "Revision actualizada."
      redirect_to [@alumno, @cuaderno_control_revision]
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

    #@cuaderno_control_revision = CuadernoControlEvento.find(params[:id])
    @cuaderno_control_revision.destroy
    
    redirect_to @alumno

#    respond_to do |format|
#      format.html { redirect_to @cuaderno_control }
#      format.json { head :no_content }
#    end
  end

  # GET /cuaderno_controles_eventos/new
  # GET /cuaderno_controles_eventos/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    #@cuaderno_control_revision = CuadernoControlEvento.new
    @cuaderno_control_revision = @alumno.cuaderno_controles_revisiones.build

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

    #@cuaderno_control_revision = CuadernoControlEvento.new(params[:cuaderno_control_revision])
    @cuaderno_control_revision = @alumno.cuaderno_controles_revisiones.build(params[:cuaderno_control_revision])
    
    if @cuaderno_control_revision.save
      flash[:notice] = "Revision agregada."
      redirect_to [@alumno, @cuaderno_control_revision]
    else
      flash[:alert] = "Revision no fue agregada."
      render :action => "new"
    end

#    respond_to do |format|
#      if @cuaderno_control_revision.save
#        format.html { redirect_to [@cuaderno_control, @cuaderno_control_revision], notice: 'Evento agregado.' }
#        format.json { render json: [@cuaderno_control, @cuaderno_control_revision], status: :created, location: @cuaderno_control_revision }
#      else
#        format.html { render action: "new", alert: "Evento no fué agregado." }
#        format.json { render json: @cuaderno_control_revision.errors, status: :unprocessable_entity }
#      end
#    end
  end
  
  private
    def find_alumno
      @alumno = Alumno.find_by_id(params[:alumno_id]) # _by_id -> para q no de error si no se accede via alumno (:alumno_id nil)
    end
    
    def find_cuaderno_control_revision
      @cuaderno_control_revision = @alumno.cuaderno_controles_revisiones.find(params[:id])
    end 
end
