class UsuariosController < ApplicationController
  load_and_authorize_resource :except => :restaurar_clave
  
  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.por_colegio(colegio.id).order("nombre")

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
    
    @personasvinculadas = PersonaVinculada.anioescolar_colegio(anio_escolar.id).where("personas_vinculadas.id not in (select persona_vinculada_id from usuarios where colegio_id = ? and persona_vinculada_id <> 0)", colegio.id).order("apellido_paterno", "apellido_materno", "nombres")
    @alumnoscolegio     = Alumno.por_anio_colegio(colegio.id, anio_escolar.id).where("alumnos.id not in (select alumno_id from usuarios where colegio_id = ? and alumno_id <> 0)", colegio.id).order("apellido_paterno", "apellido_materno", "nombres")
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
    
    if @usuario.persona_vinculada_id.nil?
      personaedita = 0
    else
      personaedita = @usuario.persona_vinculada_id
    end    
    if @usuario.alumno_id.nil?
      alumnoedita = 0
    else
      alumnoedita = @usuario.alumno_id
    end
    @personasvinculadas = PersonaVinculada.anioescolar_colegio(anio_escolar.id).where("personas_vinculadas.id not in (select persona_vinculada_id from usuarios where colegio_id = ? and persona_vinculada_id <> 0 and persona_vinculada_id <> ?)", colegio.id, personaedita).order("apellido_paterno", "apellido_materno", "nombres")
    @alumnoscolegio     = Alumno.por_anio_colegio(colegio.id, anio_escolar.id).where("alumnos.id not in (select alumno_id from usuarios where colegio_id = ? and alumno_id <> 0 and alumno_id <> ?)", colegio.id, alumnoedita)
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
    
    #@usuario = Usuario.new
    @usuarios = Usuario.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario }
    end
  end
  
  def grabar_masivo
    opcion = params[:creausuarios].to_i
    error  = 0
    
    @cole = Colegio.find(colegio.id)
    if @cole.grado_usuario.nil?
        flash[:notice] = 'Comuniquese con el administrador de MiCole para indicar el grado a partir del cual se crearan usuarios para los alumnos'
        render :crear_masivo
        return
    end
    
    if opcion == 1 || opcion == 2    # crear usuarios y notificar por correo  o solo crear usuarios
      # Creando usuarios para padres
      @nuevos_usuarios = PersonaVinculada.connection.select_rows("Select id, nombres, apellido_paterno, apellido_materno, correo From personas_vinculadas 
              Where id not in (Select persona_vinculada_id from usuarios where colegio_id= "+ colegio.id.to_s+ "and persona_vinculada_id <> 0) and id in (Select persona_vinculada_id From alumnos_personas_vinculadas 
              Join anios_alumnos on anios_alumnos.alumno_id = alumnos_personas_vinculadas.alumno_id join anios_escolares on anios_escolares.id = anios_alumnos.anio_escolar_id
              Where vigencia_vinculo= 2 And (apoderado= 1 Or autoriza_actividad = 1 Or revisa_control= 1) and anios_alumnos.anio_escolar_id = "+ anio_escolar.id.to_s+ " and anios_escolares.colegio_id= "+ colegio.id.to_s+ ")")
      
      if @nuevos_usuarios.empty?
        error  = 2
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
            if !@usuariosregistrados.empty?
              ultsec = -1
              @usuariosregistrados.each do |registrado|
                #secact= nombre.gsub(nomusu, '').to_i
                secact= registrado[0].gsub(nomusu,'').to_i
                if secact > ultsec
                  ultsec = secact
                end
              end
              if ultsec > -1
                nomusu= nomusu+ (ultsec+ 1).to_s
              end
            end
            
            clave = SecureRandom.urlsafe_base64
            if opcion == 1 && !correo.nil?
              notificado = 1
            else
              notificado = 0
            end
            @usuario = Usuario.new(
              :colegio_id => colegio.id,
              :usuario => nomusu,
              :nombre  => nombre+ " "+ apepat+ " "+ apemat,
              :clave => clave,
              :perfil_id => 2,     # Padre
              :persona_vinculada_id => idperv,
              :correo => correo,
              :notificado => notificado,
              :created_at => Time.now
            )
            if !@usuario.save
              flash[:notice] = 'Ocurrio un error al registrar los usuarios'
              error  = 1
              format.html { render action: "crear_masivo" }
            else
              if notificado == 1
                # Envio de credenciales a los usuarios para el acceso al sistema
                UsuarioMailer.delay.notificar_credencial(@usuario, clave, 1)   ## Asincrono
              end
              
              if @guardados.nil?
                @guardados = [@usuario.id]
              else
                @guardados.push(@usuario)
              end
            end
            
          end
        end
      end
      
  
      # Creando usuarios para alumnos
      @nuevos_usuarios_alumnos = AnioAlumno.connection.select_rows("Select anios_alumnos.alumno_id, alumnos.nombres, alumnos.apellido_paterno, alumnos.apellido_materno, alumnos.correo, secciones.grado_id From anios_alumnos 
              INNER JOIN alumnos ON anios_alumnos.alumno_id = alumnos.id INNER JOIN secciones ON anios_alumnos.seccion_id = secciones.id Where anios_alumnos.anio_escolar_id = "+ anio_escolar.id.to_s+ " and anios_alumnos.estado = 1 and 
              anios_alumnos.alumno_id not in (Select alumno_id from usuarios where colegio_id= "+ colegio.id.to_s+ " and alumno_id <> 0)")
      
      if !@nuevos_usuarios_alumnos.empty?
        ActiveRecord::Base.transaction do
          @nuevos_usuarios_alumnos.each do |usuario|
            grado = usuario[5].to_i
            @gradoalumno = Grado.find(grado)
            if (@gradoalumno.nivel == 1 && @gradoalumno.grado >= @cole.grado_usuario) || @gradoalumno.nivel > 1
              error  = 0
               
              idalum = usuario[0].to_i
              nombre = usuario[1]
              apepat = usuario[2]  # .strip
              apemat = usuario[3]  # .strip
              correo = usuario[4]
              nomusu = nombre[0].downcase+ apepat.downcase
              if correo.nil?   ## asignar correo del padre
                @vinculopadre = AlumnoPersonaVinculada.find_by_alumno_id_and_vigencia_vinculo_and_apoderado(idalum, 2, 1)
                if !@vinculopadre.nil?
                  correo = PersonaVinculada.find(@vinculopadre.persona_vinculada_id).correo
                end
              end
              
              # hallando la ultima secuencia de nombre de usuario
              @usuariosregistrados = Usuario.connection.select_rows("Select usuario from usuarios where usuario like '"+ nomusu+ "%'")
              if !@usuariosregistrados.empty?
                ultsec = -1
                @usuariosregistrados.each do |registrado|
                  #secact= nombre.gsub(nomusu, '').to_i
                  secact= registrado[0].gsub(nomusu,'').to_i
                  if secact > ultsec
                    ultsec = secact
                  end
                end
                if ultsec > -1
                  nomusu= nomusu+ (ultsec+ 1).to_s
                end
              end
              
              clave = SecureRandom.urlsafe_base64
              
              if opcion == 1 && !correo.nil?
                notificado = 1
              else
                notificado = 0
              end
              @usuario = Usuario.new(
                :colegio_id => colegio.id,
                :usuario => nomusu,
                :nombre  => nombre+ " "+ apepat+ " "+ apemat,
                :clave => clave,
                :perfil_id => 4,     # Alumno
                :alumno_id => idalum,
                :correo => correo,
                :notificado => notificado,
                :created_at => Time.now
              )
              if !@usuario.save
                flash[:notice] = 'Ocurrio un error al registrar los usuarios'
                error  = 1
                format.html { render action: "crear_masivo" }
              else
                if notificado == 1
                  # Envio de credenciales a los usuarios para el acceso al sistema
                  UsuarioMailer.delay.notificar_credencial(@usuario, clave, 1)   ## Asincrono
                end
                
                if @guardados.nil?
                  @guardados = [@usuario.id]
                else
                  @guardados.push(@usuario)
                end
              end
            end
            
          end
        end
      end
      
      if error == 2
        flash[:notice] = 'No existen padres o alumnos sin credenciales de acceso'
        render :crear_masivo
      end
      
    end
    
    if opcion == 3    # solo notificar por correo
      @usuarios_notificacion = Usuario.pendientenotificar(colegio.id)
      if @usuarios_notificacion.empty?
        flash[:notice] = 'No existen usuarios pendientes de notificacion de credenciales'
        error  = 1
        render :crear_masivo
      else
        # @usuario.enviar_credenciales   ## Envio de credenciales a los usuarios para el acceso al sistema
        @usuarios_notificacion.each do |usuariopendiente|
          @usuario = Usuario.find(usuariopendiente.id)
          if !@usuario.correo.nil?
            # Actualizar estado de notificado y se crea nueva contraseña
            nueva_clave = SecureRandom.urlsafe_base64
            
            # sql = 'update usuarios set notificado = 1 where id = '+ @usuario.id.to_s
            # registros = Usuario.connection.update(sql)            
            @usuario.update_attributes(
              :clave => nueva_clave,
              :notificado => 1
            )
            
            # Envio de credenciales a los usuarios para el acceso al sistema
            UsuarioMailer.delay.notificar_credencial(@usuario, nueva_clave, 1)   ## Asincrono
          end
        end
      end
    end
    if error == 0
      flash[:notice] = 'El proceso se ha realizado satisfactoriamente'
      redirect_to :controller => 'usuarios', :action => 'crear_masivo'      
    end
  end
  
  def restaurar_clave
    if request.post?
      usuario = Usuario.find_by_usuario(params[:usuario])
      
      if !usuario.nil?      
        nueva_clave = SecureRandom.urlsafe_base64
        
        usuario.update_attributes(
          :clave => nueva_clave
        )
        
        # UsuarioMailer.restaurar_clave(usuario, nueva_clave).deliver
        UsuarioMailer.notificar_credencial(usuario, nueva_clave, 2).deliver
        
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
