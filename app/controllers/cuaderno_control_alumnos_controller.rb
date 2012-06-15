class CuadernoControlAlumnosController < ApplicationController
  # GET /cuaderno_control_alumnos
  # GET /cuaderno_control_alumnos.json
  def index
    @cuaderno_control_alumnos = CuadernoControlAlumno.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuaderno_control_alumnos }
    end
  end

  # GET /cuaderno_control_alumnos/1
  # GET /cuaderno_control_alumnos/1.json
  def show
    @cuaderno_control_alumno = CuadernoControlAlumno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control_alumno }
    end
  end

  # GET /cuaderno_control_alumnos/new
  # GET /cuaderno_control_alumnos/new.json
  def new
    @cuaderno_control_alumno = CuadernoControlAlumno.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control_alumno }
    end
  end

  # GET /cuaderno_control_alumnos/1/edit
  def edit
    @cuaderno_control_alumno = CuadernoControlAlumno.find(params[:id])
  end

  # POST /cuaderno_control_alumnos
  # POST /cuaderno_control_alumnos.json
  def create
    @cuaderno_control_alumno = CuadernoControlAlumno.new(params[:cuaderno_control_alumno])

    respond_to do |format|
      if @cuaderno_control_alumno.save
        format.html { redirect_to @cuaderno_control_alumno, notice: 'Cuaderno control alumno was successfully created.' }
        format.json { render json: @cuaderno_control_alumno, status: :created, location: @cuaderno_control_alumno }
      else
        format.html { render action: "new" }
        format.json { render json: @cuaderno_control_alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuaderno_control_alumnos/1
  # PUT /cuaderno_control_alumnos/1.json
  def update
    @cuaderno_control_alumno = CuadernoControlAlumno.find(params[:id])

    respond_to do |format|
      if @cuaderno_control_alumno.update_attributes(params[:cuaderno_control_alumno])
        format.html { redirect_to @cuaderno_control_alumno, notice: 'Cuaderno control alumno was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuaderno_control_alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuaderno_control_alumnos/1
  # DELETE /cuaderno_control_alumnos/1.json
  def destroy
    @cuaderno_control_alumno = CuadernoControlAlumno.find(params[:id])
    @cuaderno_control_alumno.destroy

    respond_to do |format|
      format.html { redirect_to cuaderno_control_alumnos_url }
      format.json { head :no_content }
    end
  end
end
