class NotasController < ApplicationController
  load_and_authorize_resource
  Ruta_archivo_logs = "public/logs/log.txt";
  Ruta_directorio_archivos = "public/archivos/";  
  
  # GET /notas
  # GET /notas.json
  def index
    dni = params[:dni]
    
    @notas = Nota.por_dni(dni)
    @cursos = @notas.uniq.pluck(:curso_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notas }
    end
  end

  # GET /notas/1
  # GET /notas/1.json
  def show
    @nota = Nota.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nota }
    end
  end

  # GET /notas/new
  # GET /notas/new.json
  def new
    @nota = Nota.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nota }
    end
  end

  # GET /notas/1/edit
  def edit
    @nota = Nota.find(params[:id])
  end

  # POST /notas
  # POST /notas.json
  def create
    @nota = Nota.new(params[:nota])

    respond_to do |format|
      if @nota.save
        format.html { redirect_to @nota, notice: 'Nota was successfully created.' }
        format.json { render json: @nota, status: :created, location: @nota }
      else
        format.html { render action: "new" }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notas/1
  # PUT /notas/1.json
  def update
    @nota = Nota.find(params[:id])

    respond_to do |format|
      if @nota.update_attributes(params[:nota])
        format.html { redirect_to @nota, notice: 'Nota was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notas/1
  # DELETE /notas/1.json
  def destroy
    @nota = Nota.find(params[:id])
    @nota.destroy

    respond_to do |format|
      format.html { redirect_to notas_url }
      format.json { head :no_content }
    end
  end
  
  def cargar
   @formato_erroneo = false;
   errores = Array.new;
   if request.post?
      #Archivo subido por el usuario.
      archivo = params[:archivo];
      #Nombre original del archivo.
      nombre = archivo.original_filename;
      #Directorio donde se va a guardar.
      directorio = Ruta_directorio_archivos;
      #Extensi�n del archivo.
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
      #Verifica que el archivo tenga una extensi�n correcta.
      if extension == ".txt" or extension == ".xls" or extension == ".xlsx"
         #Ruta del archivo.
         path = File.join(directorio, nombre);
         #Crear en el archivo en el directorio. Guardamos el resultado en una variable, ser� true si el archivo se ha guardado correctamente.
         resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
         #Verifica si el archivo se subi� correctamente.
         if resultado
            res = "1";                        
            count = 0;
            File.open("#{Ruta_directorio_archivos}#{nombre}", "r").each_line do |line|                            
              begin
                count += 1
                raise StandardError, "Estructura incorrecta." if line.count("|") != 3
                
                dni, curso_abr, tipo_nota_abr, calificacion = line.split("|")
                
                raise StandardError, "Debe especificar un DNI." if dni.nil? || dni.strip == ""
                raise StandardError, "Debe especificar un curso." if curso_abr.nil? || curso_abr.strip == ""
                raise StandardError, "Debe especificar un tipo de nota." if tipo_nota_abr.nil? || tipo_nota_abr.strip == ""
                raise StandardError, "Debe especificar una calificacion." if calificacion.nil? || calificacion.strip == ""
              
                
                #raise ActiveRecord::RecordNotFound para generar error, por defecto, si no se encuentra un objeto, la variable tiene valor nil
                
                alumno = Alumno.find_by_dni(dni)
                raise ActiveRecord::RecordNotFound, "Alumno no encontrado" if alumno.nil?
                alumno_id = alumno.id
                
                anio_alumno = AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, alumno_id)
                raise ActiveRecord::RecordNotFound, "Alumno no registrado en periodo escolar" if anio_alumno.nil?
                anio_alumno_id = anio_alumno.id
                
                curso = Curso.find_by_abreviatura(curso_abr)
                raise ActiveRecord::RecordNotFound, "Curso no encontrado" if curso.nil?
                curso_id = curso.id
              
                tipo_nota = TipoNota.find_by_abreviatura(tipo_nota_abr)
                raise ActiveRecord::RecordNotFound, "Tipo de nota no encontrado" if tipo_nota.nil?
                tipo_nota_id = tipo_nota.id

                nota = Nota.find_by_anio_alumno_id_and_curso_id_and_tipo_nota_id(anio_alumno_id, curso_id, tipo_nota_id)

                #el simbolo "!" luego de update o create es para que se genere un error si algo sale mal, por defecto, el procedimiento devuelve nil sin generar error
                if !nota.nil?
                  nota.update_attributes!(
                    :nota => calificacion,
                    :usuario => current_user.usuario
                  )
                else
                  Nota.create!(
                    :anio_alumno_id => anio_alumno_id,
                    :curso_id => curso_id,
                    :tipo_nota_id => tipo_nota_id,
                    :nota => calificacion,
                    :usuario => current_user.usuario
                  )
                end
              rescue => e
                errores.push "Linea #{count}: #{e.message}"
              end
            end
        else
          res = "0";
        end
        
        #Abre el archivo de logs, Si no existe lo crea, si existe lo sobrescribe
        File.open(Ruta_archivo_logs, "w"){
          |f|;
          errores.each do |e|
            f.puts(e);
          end
          f.close();
        };
        
        if File.size?(Ruta_archivo_logs)
          res = "2";
        end
      
        #Redirige al controlador "archivos", a la acci�n "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subi� el archivo y "error" si no se pudo.
        redirect_to :controller => "notas", :action => "cargar", :res => res;
      else
        @formato_erroneo = true;
      end
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
