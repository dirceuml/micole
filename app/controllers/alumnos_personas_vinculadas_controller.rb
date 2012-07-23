class AlumnosPersonasVinculadasController < ApplicationController
  # GET /alumnos_personas_vinculadas
  # GET /alumnos_personas_vinculadas.json
  def index
    @alumnos_personas_vinculadas = AlumnoPersonaVinculada.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos_personas_vinculadas }
    end
  end

  # GET /alumnos_personas_vinculadas/1
  # GET /alumnos_personas_vinculadas/1.json
  def show
    @alumno_persona_vinculada = AlumnoPersonaVinculada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno_persona_vinculada }
    end
  end

  # GET /alumnos_personas_vinculadas/new
  # GET /alumnos_personas_vinculadas/new.json
  def new
    @alumno_persona_vinculada = AlumnoPersonaVinculada.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno_persona_vinculada }
    end
  end

  # GET /alumnos_personas_vinculadas/1/edit
  def edit
    @alumno_persona_vinculada = AlumnoPersonaVinculada.find(params[:id])
  end

  # POST /alumnos_personas_vinculadas
  # POST /alumnos_personas_vinculadas.json
  def create
    @alumno = Alumno.find(params[:alumno_id])
    @alumno_persona_vinculada = @alumno.alumnos_personas_vinculadas.create(params[:alumno_persona_vinculada])
#    redirect_to alumno_path(@alumno)
    respond_to do |format|
      if @alumno_persona_vinculada.save
        format.html { redirect_to @alumno }
        format.json { render json: @alumno_persona_vinculada, status: :created, location: @alumno_persona_vinculada }
      else
        format.html { redirect_to @alumno }
        format.json { render json: @alumno_persona_vinculada.errors, status: :unprocessable_entity }
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
  end

  # PUT /alumnos_personas_vinculadas/1
  # PUT /alumnos_personas_vinculadas/1.json
  def update
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
    @alumno = Alumno.find(params[:alumno_id])
    @alumno_persona_vinculada = @alumno.alumnos_personas_vinculadas.find(params[:id])
    @alumno_persona_vinculada.destroy
    
    redirect_to alumno_path(@alumno)
  end
end
