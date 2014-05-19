class AlumnosController < ApplicationController
  load_and_authorize_resource
  
  # GET /alumnos
  # GET /alumnos.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    
    seccion_id = params[:seccion_id]
    
    if seccion_id.nil? || seccion_id == ""
      @alumnos = Alumno.por_anio_colegio(anio_escolar.id, colegio.id)
    else
      @alumnos = Alumno.pertenecen_a_seccion(anio_escolar.id, seccion_id)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end
  end
  
  # GET /vincularpersona
  # GET /vincularpersona.json
  def alumnoseccion
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    seccion = params[:seccion_id]
    
    if !seccion.nil?
      @alumnos = Alumno.pertenecen_a_seccion(anio_escolar.id, seccion)
    else
      @alumnos = Alumno.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end
  end
  
  # GET /vincularpersona/1
  # GET /vincularpersona/1.json
  def alumnopersona        # vincularpersona
    @alumno = Alumno.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno }
    end
  end  
  
  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
    @alumno = Alumno.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno }
    end
  end
  

  # GET /alumnos/new
  # GET /alumnos/new.json
  def new
    @alumno = Alumno.new   
    #1.times { @alumno.alumnos_personas_vinculadas.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno }
    end
  end

  # GET /alumnos/1/edit
  def edit
    @alumno = Alumno.find(params[:id])
    @seccion_id = Alumno.find(@alumno.id).seccion_id(anio_escolar.id)
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    if params[:alumno][:salida_con_persona] == "1" && params[:alumno][:alumnos_personas_vinculadas_attributes].nil?
      @seccion_id = params[:seccion_id]  
      flash[:notice] = "Debe vincular una persona"
      render "new"
    else
      @alumno = Alumno.new(params[:alumno])  
      seccion_id = params[:seccion_id]    

      respond_to do |format|
        ActiveRecord::Base.transaction do
          if @alumno.save
            AnioAlumno.create!(
              :anio_escolar_id => anio_escolar.id,
              :alumno_id => @alumno.id,
              :usuario => current_user.usuario,
              :seccion_id => seccion_id,
              :estado => 1
            )

            format.html { redirect_to @alumno, notice: 'El alumno fue creado satisfactoriamente.' }
            format.json { render json: @alumno, status: :created, location: @alumno }
          else
            format.html { render action: "new" }
            format.json { render json: @alumno.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PUT /alumnos/1
  # PUT /alumnos/1.json
  def update
    if params[:alumno][:salida_con_persona] == "1" && params[:alumno][:alumnos_personas_vinculadas_attributes].nil?
      flash[:notice] = "Debe vincular una persona"
      render "edit"
    else
      @alumno = Alumno.find(params[:id])
      seccion_id = params[:seccion_id] 

      respond_to do |format|
        ActiveRecord::Base.transaction do
          if @alumno.update_attributes(params[:alumno])
            anio_alumno = AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, @alumno.id)
            anio_alumno.update_attributes!(
              :usuario => current_user.usuario,
              :seccion_id => seccion_id
            )

            format.html { redirect_to @alumno, notice: 'El alumno fue actualizado satisfactoriamente.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @alumno.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno = Alumno.find(params[:id])
    @alumno.destroy

    respond_to do |format|
      format.html { redirect_to alumnos_url }
      format.json { head :no_content }
    end
  end
  
  def alumnos_personas_vinculadas
    @alumnos = Alumno.all
    @personas_vinculadas = @PersonaVinculada.all
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to menu_url, :alert => exception.message
    end
  end
end
