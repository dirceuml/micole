class PersonasVinculadasController < ApplicationController    
  # GET /personas_vinculadas
  # GET /personas_vinculadas.json
  def index
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @personas_vinculadas = PersonaVinculada.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @personas_vinculadas }
    end
  end

  # GET /personas_vinculadas/1
  # GET /personas_vinculadas/1.json
  def show
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @persona_vinculada }
    end
  end

  # GET /personas_vinculadas/new
  # GET /personas_vinculadas/new.json
  def new
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @persona_vinculada }
    end
  end

  # GET /personas_vinculadas/1/edit
  def edit
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:id])
  end

  # POST /personas_vinculadas
  # POST /personas_vinculadas.json
  def create
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.new(params[:persona_vinculada])
                
#    if !@persona_vinculada.foto.nil?
#      archivo = @persona_vinculada.foto
#      name = @persona_vinculada.tipo_documento.to_s.rjust(3, "0") + @persona_vinculada.numero_documento.rjust(10, "0") + archivo.original_filename[-4, 4]
#      directory = "app/assets/images"
#      path = File.join(directory, name) 
#
#      @persona_vinculada.foto = name
#    end
    
    respond_to do |format|
      if @persona_vinculada.save
#        if (archivo)
#          File.open(path, "wb") { |f| f.write(archivo.read) }
#        end
        format.html { redirect_to @persona_vinculada, notice: 'Persona vinculada creada satisfactoriamente.' }
        format.json { render json: @persona_vinculada, status: :created, location: @persona_vinculada }
      else
        format.html { render action: "new" }
        format.json { render json: @persona_vinculada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /personas_vinculadas/1
  # PUT /personas_vinculadas/1.json
  def update
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:id])
    
#    img_orig = Magick::Image.read(params[:persona_vinculada][:foto]).first
#    archivo = img_orig.resize_to_fit(x,75)   
    
#    image_orig.change_geometry!("640x480") { |cols, rows, img|
#        newimg = img.resize(cols, rows)
#        newimg.write("newfilename.jpg")
#    }
       
#    if !params[:persona_vinculada][:foto].nil?
#      archivo = params[:persona_vinculada][:foto]
#      name = params[:persona_vinculada][:tipo_documento].to_s.rjust(3, "0") + params[:persona_vinculada][:numero_documento].rjust(10, "0") + archivo.original_filename[-4, 4]
#      directory = "app/assets/images"
#      path = File.join(directory, name) 
#
#      params[:persona_vinculada][:foto] = name
#    end

    respond_to do |format|
      if @persona_vinculada.update_attributes(params[:persona_vinculada])
#        if !archivo.nil?
#          File.open(path, "wb") { |f| f.write(archivo.read) }
#        end
        format.html { redirect_to @persona_vinculada, notice: 'Persona vinculada fue actualizada satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @persona_vinculada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas_vinculadas/1
  # DELETE /personas_vinculadas/1.json
  def destroy
    if current_user.nil?
      redirect_to(log_in_path) and return
    end

    @persona_vinculada = PersonaVinculada.find(params[:id])
    @persona_vinculada.destroy

    respond_to do |format|
      format.html { redirect_to personas_vinculadas_url }
      format.json { head :no_content }
    end
  end
end
