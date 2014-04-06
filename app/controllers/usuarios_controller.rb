class UsuariosController < ApplicationController
  load_and_authorize_resource :except => :restaurar_clave
  
  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.json
  def new
    @usuario = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to @usuario, notice: 'Usuario fue creado satisfactoriamente' }
        format.json { render json: @usuario, status: :created, location: @usuario }
      else
        format.html { render action: "new" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.json
  def update
    @usuario = Usuario.find(params[:id])
    
    if !params[:clave_actual].nil?
      user = Usuario.authenticate(params[:usuario], params[:clave_actual])
      
      if !user
        format.html { render action: "cambiar_clave" }
      end
    end
    
    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        format.html { redirect_to @usuario, notice: 'Usuario fue actualizado satisfactoriamente' }
        format.json { head :no_content }
      else
        if params[:perfil_id].nil?
          format.html { render action: "cambiar_clave" }
        else
          format.html { render action: "edit" }
        end
        
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to usuarios_url }
      format.json { head :no_content }
    end
  end
  
  def crear_masivo
    if current_user.nil?
      redirect_to(log_in_path) and return
    end
    #if params[:opcion].nil?
    #  @usuarios = Usuarios.all
    #else
    opcion = 1
    @usuarios = Usuario.all
    #end
    
    # @usuario = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario }
    end
  end
  
  def grabar_masivo
     
    @nuevos_usuarios = PersonaVinculada.connection.select_rows("Select id, nombres, apellido_paterno, apellido_materno, correo From personas_vinculadas 
              Where id not in (Select persona_vinculada_id from usuarios where colegio_id= 1 and persona_vinculada_id <> 0) and id in (Select persona_vinculada_id From alumnos_personas_vinculadas 
              Join anios_alumnos on anios_alumnos.alumno_id = alumnos_personas_vinculadas.alumno_id join anios_escolares on anios_escolares.id = anios_alumnos.anio_escolar_id
              Where vigencia_vinculo= 2 And (apoderado= 1 Or autoriza_actividad = 1 Or revisa_control= 1) and anios_alumnos.anio_escolar_id = 1 and anios_escolares.colegio_id= 1)")
      
    if @nuevos_usuarios.nil?
      flash[:notice] = 'No existen personas vinculadas sin usuario'
      render :crear_masivo
    else
      ActiveRecord::Base.transaction do
        @nuevos_usuarios.each do |usuario|
          idperv = usuario[0].to_i
          correo = usuario[4]
          nombre = usuario[1]
          apepat = usuario[2]  # .strip
          apemat = usuario[3]  # .strip
          nomusu = nombre[0].downcase+ apepat.downcase
          
          #cantidadusuario = Usuario.count(:all).where("usuario like '?%'",nomusu)
          
          # hallando la ultima secuencia de nombre de usuario
          @usuariosregistrados = Usuario.connection.select_rows("Select usuario from usuarios where usuario like '"+ nomusu+ "%'")
          if !@usuariosregistrados.nil?
            ultsec = 0
            @usuariosregistrados.each do |registrado|
              #secact= nombre.gsub(nomusu, '').to_i
              secact= registrado[0].reverse.to_i
              if secact > ultsec
                ultsec = secact
              end
            end
            nomusu= nomusu+ (ultsec+ 1).to_s
          end
          
          clave  = nomusu
          @usuario = Usuario.new(
            :colegio_id => 1,
            :usuario => nomusu,
            :nombre  => nombre+ " "+ apepat+ " "+ apemat,
            :clave => clave,
            :perfil_id => 2,     # Padre
            :persona_vinculada_id => idperv,
            :correo => correo,
            :created_at => Time.now
          )
          if !@usuario.save
            flash[:notice] = 'Ocurrio un error al registrar los usuarios'
            format.html { render action: "crear_masivo" }
          else
            if @guardados.nil?
              @guardados = [@usuario.id]
            else
              @guardados.push(@usuario)
            end
          end
        end
      end
    end
    
    redirect_to :controller => 'usuarios', :action => 'crear_masivo'
  end
  
  def restaurar_clave
    if request.post?
      usuario = Usuario.find_by_usuario(params[:usuario])
      
      if !usuario.nil?      
        nueva_clave = SecureRandom.urlsafe_base64

        usuario.update_attributes(
          :clave => nueva_clave
        )

        UsuarioMailer.restaurar_clave(usuario, nueva_clave).deliver

        res = "1"
      else
        res = "2"
      end
      
      redirect_to :controller => "usuarios", :action => "restaurar_clave", :res => res;
    end
  end
  
  # GET /usuarios/1/cambiar_clave
  def cambiar_clave
    @usuario = Usuario.find(params[:id])
  end
  
  # GET /usuarios/1/expiracion/5
  # GET /usuarios/1.json
  def expiracion
    @usuario = Usuario.find(params[:id])
    @dias = params[:dias]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usuario }
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
