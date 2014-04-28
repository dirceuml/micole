class CuadernoControlesEventosController < ApplicationController
  load_and_authorize_resource
  
  before_filter :find_cuaderno_control
  
  before_filter :find_cuaderno_control_evento, :only => [:show,
                                                          :edit,
                                                          :update,
                                                          :destroy]

  # GET /cuaderno_controles_eventos
  # GET /cuaderno_controles_eventos.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_controles_eventos = CuadernoControlEvento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuaderno_controles_eventos }
    end
  end

  # GET /cuaderno_controles_eventos/1
  # GET /cuaderno_controles_eventos/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    #    @cuaderno_control_evento = CuadernoControlEvento.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @cuaderno_control_evento }
#    end
  end

  # GET /cuaderno_controles_eventos/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    #@cuaderno_control_evento = CuadernoControlEvento.find(params[:id])
  end
  
 
  # PUT /cuaderno_controles_eventos/1
  # PUT /cuaderno_controles_eventos/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    if @cuaderno_control_evento.update_attributes(params[:cuaderno_control_evento])
      flash[:notice] = "Evento actualizado."
      redirect_to [@cuaderno_control, @cuaderno_control_evento]
    else
      flash[:alert] = "Evento no fue actualizado."
      render :action => "edit"
    end
  end
  

  # DELETE /cuaderno_controles_eventos/1
  # DELETE /cuaderno_controles_eventos/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    #@cuaderno_control_evento = CuadernoControlEvento.find(params[:id])
    @cuaderno_control_evento.destroy
    
    redirect_to @cuaderno_control

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

    #@cuaderno_control_evento = CuadernoControlEvento.new
    @cuaderno_control_evento = @cuaderno_control.cuaderno_controles_eventos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control_evento }
    end
  end

  # POST /cuaderno_controles_eventos
  # POST /cuaderno_controles_eventos.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    #@cuaderno_control_evento = CuadernoControlEvento.new(params[:cuaderno_control_evento])
    @cuaderno_control_evento = @cuaderno_control.cuaderno_controles_eventos.build(params[:cuaderno_control_evento])
    
    if @cuaderno_control_evento.save
      #flash[:notice] = "Evento agregado."
      #redirect_to [@cuaderno_control, @cuaderno_control_evento] # cuadernos_controles_revisiones#show
      if !@cuaderno_control_evento.alumno_id.nil?
        if TipoEvento.find(@cuaderno_control_evento.tipo_evento_id).notificacion_inmediata == 1
          PersonaVinculada.receptores_notificacion_evento(@cuaderno_control_evento.id).find_each do |p|
            #EventoMailer.delay.notificacion_evento(@cuaderno_control_evento, p).deliver
            EventoMailer.delay.notificacion_evento(@cuaderno_control_evento, p)
          end
        end
      end
      
      redirect_to @cuaderno_control # cuadernos_controles#show
    else
      flash[:alert] = "Evento no fue agregado."
      render :action => "new"
    end

#    respond_to do |format|
#      if @cuaderno_control_evento.save
#        format.html { redirect_to [@cuaderno_control, @cuaderno_control_evento], notice: 'Evento agregado.' }
#        format.json { render json: [@cuaderno_control, @cuaderno_control_evento], status: :created, location: @cuaderno_control_evento }
#      else
#        format.html { render action: "new", alert: "Evento no fué agregado." }
#        format.json { render json: @cuaderno_control_evento.errors, status: :unprocessable_entity }
#      end
#    end
  end
  
  private
    def find_cuaderno_control
      @cuaderno_control = CuadernoControl.find(params[:cuaderno_control_id])
    end
    
    def find_cuaderno_control_evento
      @cuaderno_control_evento = @cuaderno_control.cuaderno_controles_eventos.find(params[:id])
    end 
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to menu_url, :alert => exception.message
    end
  end
end
