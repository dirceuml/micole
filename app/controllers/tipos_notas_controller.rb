class TiposNotasController < ApplicationController
  load_and_authorize_resource
  
  # GET /tipos_notas
  # GET /tipos_notas.json
  def index
    @tipos_notas = TipoNota.por_anio_escolar(anio_escolar.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipos_notas }
    end
  end

  # GET /tipos_notas/1
  # GET /tipos_notas/1.json
  def show
    @tipo_nota = TipoNota.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_nota }
    end
  end

  # GET /tipos_notas/new
  # GET /tipos_notas/new.json
  def new
    @tipo_nota = TipoNota.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_nota }
    end
  end

  # GET /tipos_notas/1/edit
  def edit
    @tipo_nota = TipoNota.find(params[:id])
  end

  # POST /tipos_notas
  # POST /tipos_notas.json
  def create
    @tipo_nota = TipoNota.new(params[:tipo_nota])

    respond_to do |format|
      if @tipo_nota.save
        format.html { redirect_to @tipo_nota, notice: 'El tipo de nota fue creado satisfactoriamente.' }
        format.json { render json: @tipo_nota, status: :created, location: @tipo_nota }
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipos_notas/1
  # PUT /tipos_notas/1.json
  def update
    @tipo_nota = TipoNota.find(params[:id])

    respond_to do |format|
      if @tipo_nota.update_attributes(params[:tipo_nota])
        format.html { redirect_to @tipo_nota, notice: 'El tipo de nota fue actualizado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_notas/1
  # DELETE /tipos_notas/1.json
  def destroy
    @tipo_nota = TipoNota.find(params[:id])
    @tipo_nota.destroy

    respond_to do |format|
      format.html { redirect_to tipos_notas_url }
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
