class AniosEscolaresController < ApplicationController
  load_and_authorize_resource
  
  # GET /anios_escolares
  # GET /anios_escolares.json
  def index
    @anios_escolares = AnioEscolar.order("anio") # all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @anios_escolares }
    end
  end

  # GET /anios_escolares/1
  # GET /anios_escolares/1.json
  def show
    @anio_escolar = AnioEscolar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @anio_escolar }
    end
  end

  # GET /anios_escolares/new
  # GET /anios_escolares/new.json
  def new
    @anio_escolar = AnioEscolar.new
    
    ultimoanio = AnioEscolar.anioescolarcolegio(1).maximum('anio')
    if ultimoanio.nil?
      ultimoanio = Time.now.year - 1
    end
    @anio_escolar.anio = ultimoanio+ 1
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @anio_escolar }
    end
  end

  # GET /anios_escolares/1/edit
  def edit
    @anio_escolar = AnioEscolar.find(params[:id])
  end

  # POST /anios_escolares
  # POST /anios_escolares.json
  def create
    @anio_escolar = AnioEscolar.new(params[:anio_escolar])
    respond_to do |format|
      if @anio_escolar.save
        if @anio_escolar.activo == 1
          # Desactivar otros años escolares
          sql = 'update anios_escolares set activo = 0 where colegio_id = '+ @anio_escolar.colegio_id.to_s + ' And activo = 1 And id <> '+ @anio_escolar.id.to_s
          registros = AnioEscolar.connection.update(sql)
        end
        format.html { redirect_to @anio_escolar, notice: 'El registro fue creado satisfactoriamente.' }
        format.json { render json: @anio_escolar, status: :created, location: @anio_escolar }
      else
        format.html { render action: "new" }
        format.json { render json: @anio_escolar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /anios_escolares/1
  # PUT /anios_escolares/1.json
  def update
    @anio_escolar = AnioEscolar.find(params[:id])

    respond_to do |format|
      if @anio_escolar.update_attributes(params[:anio_escolar])
        
        if @anio_escolar.activo == 1
          sql = 'update anios_escolares set activo = 0 where colegio_id = '+ @anio_escolar.colegio_id.to_s + ' And activo = 1 And id <> '+ @anio_escolar.id.to_s
          registros = AnioEscolar.connection.update(sql)
        end
        
        format.html { redirect_to @anio_escolar, notice: 'El registro fue actualizado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @anio_escolar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anios_escolares/1
  # DELETE /anios_escolares/1.json
  def destroy
    @anio_escolar = AnioEscolar.find(params[:id])
    @anio_escolar.destroy

    respond_to do |format|
      format.html { redirect_to anios_escolares_url }
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
