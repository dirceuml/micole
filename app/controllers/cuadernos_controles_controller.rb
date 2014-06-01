class CuadernosControlesController < ApplicationController
  load_and_authorize_resource
  
  # GET /cuadernos_controles
  # GET /cuadernos_controles.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuadernos_controles = CuadernoControl.order("estado, fecha desc, seccion_id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuadernos_controles }
    end
  end

  # GET /cuadernos_controles/1
  # GET /cuadernos_controles/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control }
    end
  end

  # GET /cuadernos_controles/new
  # GET /cuadernos_controles/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control }
    end
  end

  # GET /cuadernos_controles/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])
  end

  # GET /cuadernos_controles/1/cerrar
  def cerrar
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])
    
    if @cuaderno_control.cuaderno_controles_eventos.count == 0 then
      flash[:notice] = "Debe registrar al menos un evento."
      redirect_to @cuaderno_control and return
    end

    respond_to do |format|
      if @cuaderno_control.update_attributes(:estado => 2)
        sql = 'Insert Into cuaderno_controles_revisiones (cuaderno_control_id, alumno_id,
          usuario, created_at, updated_at, revisado)  
        (Select cc.id, a.alumno_id, \'' + current_user.usuario + '\', current_date, current_date, 0
        From cuadernos_controles cc, anios_alumnos a
        Where cc.id = ' + @cuaderno_control.id.to_s + '
          And cc.seccion_id = a.seccion_id And a.estado = 1)
        Returning id'
        
        if CuadernoControlRevision.connection.insert(sql)
          format.html { redirect_to @cuaderno_control, notice: 'Cuaderno de control cerrado satisfactoriamente.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @cuaderno_control, notice: 'Cuaderno de control fue cerrado.' } #OJO
          format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @cuaderno_control, notice: 'Cuaderno de control no fue cerrado.' }
        format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
      end
      
#      if @cuaderno_control.update_attributes(:estado => 2)        
#        format.html { redirect_to @cuaderno_control, notice: 'Cuaderno de control cerrado satisfactoriamente.' }
#        format.json { head :no_content }
#      else
#        format.html { redirect_to @cuaderno_control, notice: 'Cuaderno de control fue cerrado.' } #OJO
#        format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
#      end
    end
  end

  # POST /cuadernos_controles
  # POST /cuadernos_controles.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.new(params[:cuaderno_control])

    respond_to do |format|
      if @cuaderno_control.save
        #format.html { redirect_to @cuaderno_control }
        format.html { redirect_to new_cuaderno_control_cuaderno_control_evento_path(@cuaderno_control) }
        format.json { render json: @cuaderno_control, status: :created, location: @cuaderno_control }
      else
        format.html { render action: "new" }
        format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuadernos_controles/1
  # PUT /cuadernos_controles/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])

    respond_to do |format|
      if @cuaderno_control.update_attributes(params[:cuaderno_control])
        format.html { redirect_to @cuaderno_control, notice: 'Cuaderno control was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuaderno_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuadernos_controles/1
  # DELETE /cuadernos_controles/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @cuaderno_control = CuadernoControl.find(params[:id])
    @cuaderno_control.destroy

    respond_to do |format|
      format.html { redirect_to cuadernos_controles_url }
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