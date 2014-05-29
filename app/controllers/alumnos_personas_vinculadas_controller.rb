class AlumnosPersonasVinculadasController < ApplicationController
  load_and_authorize_resource
  
  # usandovincularpersona = 1  si se usa la url vincularpersona/:id para asociar nuevas personas vinculadas o eliminar vinculos.
  # usandovincularpersona = 0  si se usa la url alumnos/:id para asociar nuevas personas vinculadas o eliminar vinculos (programa original).
  Usandovincularpersona = 1
  
  # GET /alumnos_personas_vinculadas
  # GET /alumnos_personas_vinculadas.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @alumnos_personas_vinculadas = AlumnoPersonaVinculada.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos_personas_vinculadas }
    end
  end
  
  # GET /alumnos_personas_vinculadas/1/consultar
  # GET /alumnos_personas_vinculadas/1/consultar.json
  def consultar
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    tipo = params[:tipo_documento]
    numero = params[:numero_documento]
    
    if !numero.nil?
      if !PersonaVinculada.find_by_tipo_documento_and_numero_documento(tipo,numero)
        flash[:notice] = "El numero de documento #{numero} no existe"
      else
        @alumnos_personas_vinculadas = AlumnoPersonaVinculada.por_documento(tipo,numero)
        if @alumnos_personas_vinculadas.empty?
          flash[:notice] = "La persona no tiene ningun alumno encargado"
        end
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end
  end

  # GET /alumnos_personas_vinculadas/1
  # GET /alumnos_personas_vinculadas/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @alumno_persona_vinculada = AlumnoPersonaVinculada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno_persona_vinculada }
    end
  end

  # GET /alumnos_personas_vinculadas/new
  # GET /alumnos_personas_vinculadas/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @alumno_persona_vinculada = AlumnoPersonaVinculada.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno_persona_vinculada }
    end
  end

  # GET /alumnos_personas_vinculadas/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @alumno_persona_vinculada = AlumnoPersonaVinculada.find(params[:id])
  end

  # POST /alumnos_personas_vinculadas
  # POST /alumnos_personas_vinculadas.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @alumno = Alumno.find(params[:alumno_id])
    @alumno_persona_vinculada = @alumno.alumnos_personas_vinculadas.create(params[:alumno_persona_vinculada])
    
    respond_to do |format|
      if @alumno_persona_vinculada.save
        if Usandovincularpersona == 1
          format.html { redirect_to :controller => 'alumnos', :action => 'alumnopersona' , :id => @alumno.id}
        else
          format.html { redirect_to @alumno }
          format.json { render json: @alumno, status: :created, location: @alumno }
        end
      else
        @alumno_persona_vinculada.persona_vinculada_id = ""
        if Usandovincularpersona == 1
          # para mostrar los errores en pantalla usar render, no redirect_to. Al usar render no es necesario enviar el id
          format.html { render 'alumnos/alumnopersona' }
          format.json { render json: @alumno.errors, status: :unprocessable_entity }
        else
          format.html { render 'alumnos/show' }
          format.json { render json: @alumno.errors, status: :unprocessable_entity }
        end
      end
    end
  end
    
  def create2
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:alumno_persona_vinculada][:persona_vinculada_id])
    @alumno_persona_vinculada = @persona_vinculada.alumnos_personas_vinculadas.create(params[:alumno_persona_vinculada])
    
    respond_to do |format|
      if @alumno_persona_vinculada.save
        format.html { redirect_to @persona_vinculada }
        format.json { render json: @persona_vinculada, status: :created, location: @persona_vinculada }
      else
        @alumno_persona_vinculada.persona_vinculada_id = ""
        format.html { render 'personas_vinculadas/show' }
        format.json { render json: @persona_vinculada.errors, status: :unprocessable_entity }
      end
    end
  end
    
    
#    @alumno_persona_vinculada = AlumnoPersonaVinculada.new(params[:alumno_persona_vinculada])

#    respond_to do |format|
#      if @alumno_persona_vinculada.save
#        format.html { redirect_to @alumno_persona_vinculada, notice: 'Alumno persona vinculada was successfully created.' }
#        format.json { render json: @alumno_persona_vinculada, status: :created, location: @alumno_persona_vinculada }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @alumno_persona_vinculada.errors, status: :unprocessable_entity }
#      end
#    end
# end

  # PUT /alumnos_personas_vinculadas/1
  # PUT /alumnos_personas_vinculadas/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @alumno_persona_vinculada = AlumnoPersonaVinculada.find(params[:id])

    respond_to do |format|
      if @alumno_persona_vinculada.update_attributes(params[:alumno_persona_vinculada])
        format.html { redirect_to @alumno_persona_vinculada, notice: 'Alumno persona vinculada was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alumno_persona_vinculada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos_personas_vinculadas/1
  # DELETE /alumnos_personas_vinculadas/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    @alumno_persona_vinculada = AlumnoPersonaVinculada.find(params[:id])
    @persona_vinculada = PersonaVinculada.find(@alumno_persona_vinculada.persona_vinculada_id)
    @alumno = Alumno.find(@alumno_persona_vinculada.alumno_id)
    @alumno_persona_vinculada.destroy
    
    if params[:origen] == "1"
      redirect_to persona_vinculada_path(@alumno)     
    else
      redirect_to persona_vinculada_path(@persona_vinculada)     
    end
    

#    @alumno = Alumno.find(params[:alumno_id])
#    @alumno_persona_vinculada = @alumno.alumnos_personas_vinculadas.find(params[:id])
#    @alumno_persona_vinculada.destroy
#    
#    if Usandovincularpersona == 1
#      redirect_to :controller => 'alumnos', :action => 'alumnopersona' , :id => @alumno.id
#    else
#      redirect_to alumno_path(@alumno)      
#    end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to menu_url, :alert => exception.message
    end
  end
end
