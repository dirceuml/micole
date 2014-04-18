class AniosAlumnosController < ApplicationController
  load_and_authorize_resource
  
  # GET /anios_alumnos
  # GET /anios_alumnos.json
  def index
    seccion = params[:seccion_id]
    
    if !seccion.nil?
      @anios_alumnos = AnioAlumno.pertenecen_a_seccion(seccion)
    else
      @anios_alumnos = AnioAlumno.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @anios_alumnos }
    end
  end

  # GET /anios_alumnos/1
  # GET /anios_alumnos/1.json
  def show
    @anio_alumno = AnioAlumno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @anio_alumno }
    end
  end

  # GET /anios_alumnos/new
  # GET /anios_alumnos/new.json
  def new
    @anio_alumno = AnioAlumno.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @anio_alumno }
    end
  end

  # GET /anios_alumnos/1/edit
  def edit
    @anio_alumno = AnioAlumno.find(params[:id])
  end

  # POST /anios_alumnos
  # POST /anios_alumnos.json
  def create
    @anio_alumno = AnioAlumno.new(params[:anio_alumno])

    respond_to do |format|
      if @anio_alumno.save
        format.html { redirect_to @anio_alumno, notice: 'Matricula del alumno fue creado satisfactoriamente.' }
        format.json { render json: @anio_alumno, status: :created, location: @anio_alumno }
      else
        format.html { render action: "new" }
        format.json { render json: @anio_alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /anios_alumnos/1
  # PUT /anios_alumnos/1.json
  def update
    @anio_alumno = AnioAlumno.find(params[:id])

    respond_to do |format|
      if @anio_alumno.update_attributes(params[:anio_alumno])
        format.html { redirect_to @anio_alumno, notice: 'Matricula del alumno fue actualizado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @anio_alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anios_alumnos/1
  # DELETE /anios_alumnos/1.json
  def destroy
    @anio_alumno = AnioAlumno.find(params[:id])
    @anio_alumno.destroy

    respond_to do |format|
      format.html { redirect_to anios_alumnos_url }
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
