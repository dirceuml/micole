class ArchivosController < ApplicationController
  layout 'admin'
  Ruta_archivo_logs = "public/logs/log.txt";
  Ruta_directorio_archivos = "public/archivos/";
  
  def subir_archivos
   @formato_erroneo = false;
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
            subir_archivo = "ok";
         else
            subir_archivo = "error";
         end
         #Redirige al controlador "archivos", a la acci�n "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subi� el archivo y "error" si no se pudo.
         redirect_to :controller => "archivos", :action => "listar_archivos", :subir_archivo => subir_archivo;
      else
         @formato_erroneo = true;
      end
    end
 end
 
  def cargar_alumnos
   @formato_erroneo = false;
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
            subir_archivo = "ok";
            
            File.open("#{Ruta_directorio_archivos}#{nombre}", "r").each_line do |line|
              dni, nombres, apellido_paterno, apellido_materno, fecha_nacimiento, telefono_fijo, telefono_movil, direccion, correo = line.split("|")
              
              alumno = Alumno.find_by_dni(dni)

              if !alumno.nil?
                alumno.update_attributes(
                  :nombres => nombres,
                  :apellido_paterno => apellido_paterno,
                  :apellido_materno => apellido_materno,
                  :fecha_nacimiento => fecha_nacimiento,
                  :telefono_fijo => telefono_fijo,
                  :telefono_movil => telefono_movil,
                  :direccion => direccion,
                  :correo => correo,
                  :usuario => :current_user
                )
              else
                Alumno.create(
                  :dni => dni,
                  :nombres => nombres,
                  :apellido_paterno => apellido_paterno,
                  :apellido_materno => apellido_materno,
                  :fecha_nacimiento => fecha_nacimiento,
                  :telefono_fijo => telefono_fijo,
                  :telefono_movil => telefono_movil,
                  :direccion => direccion,
                  :correo => correo,
                  :usuario => :current_user
                )
              end
            
            
            end
         else
            subir_archivo = "error";
         end
         #Redirige al controlador "archivos", a la acci�n "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subi� el archivo y "error" si no se pudo.
         redirect_to :controller => "archivos", :action => "listar_archivos", :subir_archivo => subir_archivo;
      else
         @formato_erroneo = true;
      end
    end
 end
 
  
  def cargar_padres
   @formato_erroneo = false;
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
            subir_archivo = "ok";
            
            File.open("#{Ruta_directorio_archivos}#{nombre}", "r").each_line do |line|
              tipo_documento, numero_documento, nombres, apellido_paterno, apellido_materno, telefono_fijo, telefono_movil, correo = line.split("|")
              
              padre = PersonaVinculada.find_by_tipo_documento_and_numero_documento(tipo_documento, numero_documento)

              if !padre.nil?
                padre.update_attributes(
                  :nombres => nombres,
                  :apellido_paterno => apellido_paterno,
                  :apellido_materno => apellido_materno,
                  :telefono_fijo => telefono_fijo,
                  :telefono_movil => telefono_movil,
                  :correo => correo,
                  :user => :current_user
                )
              else
                PersonaVinculada.create(
                  :tipo_documento => tipo_documento,
                  :numero_documento => numero_documento,
                  :nombres => nombres,
                  :apellido_paterno => apellido_paterno,
                  :apellido_materno => apellido_materno,
                  :telefono_fijo => telefono_fijo,
                  :telefono_movil => telefono_movil,
                  :correo => correo,
                  :foto => "foto.jpg",
                  :user => :current_user,
                  :origen => "carga"
                )
                
              end
            end
         else
            subir_archivo = "error";
         end
         #Redirige al controlador "archivos", a la acci�n "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subi� el archivo y "error" si no se pudo.
         redirect_to :controller => "archivos", :action => "listar_archivos", :subir_archivo => subir_archivo;
      else
         @formato_erroneo = true;
      end
    end
 end
 
  
  
  def cargar_vinculos
   @formato_erroneo = false;
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
            subir_archivo = "ok";
            
            File.open("#{Ruta_directorio_archivos}#{nombre}", "r").each_line do |line|
              dni_alumno, tipo_documento_padre, numero_documento_padre, inicio_vigencia = line.split("|")
              
              alumno = Alumno.find_by_dni(dni_alumno)
              padre = PersonaVinculada.find_by_tipo_documento_and_numero_documento(tipo_documento_padre, numero_documento_padre)

              vinculo = AlumnoPersonaVinculada.find_by_persona_vinculada_id_and_alumno_id(padre.id, alumno.id)

              if !vinculo.nil?
                vinculo.update_attributes(
                  :persona_vinculada_id => padre.id,
                  :alumno_id => alumno.id,
                  :inicio_vigencia => inicio_vigencia,
                  :usuario => :current_user
                )
              else
                AlumnoPersonaVinculada.create(
                  :persona_vinculada_id => padre.id,
                  :alumno_id => alumno.id,
                  :inicio_vigencia => inicio_vigencia,
                  :tipo_vinculo => 1,
                  :vigencia_vinculo => 2,
                  :apoderado => 1,
                  :autoriza_actividad => 1,
                  :revisa_control => 1,
                  :usuario => :current_user
                )
              end
            end
         else
            subir_archivo = "error";
         end
         #Redirige al controlador "archivos", a la acci�n "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subi� el archivo y "error" si no se pudo.
         redirect_to :controller => "archivos", :action => "listar_archivos", :subir_archivo => subir_archivo;
      else
         @formato_erroneo = true;
      end
    end
 end

  def listar_archivos
   #Guardamos la lista de archivos de la carpeta "archivos".
   @archivos = Dir.entries(Ruta_directorio_archivos);
   #Mensaje que mostrar� si la p�gina viene desde otra acci�n.
   @mensaje = "";
   #Verificamos si existe la variable subir_archivo por GET.
   if params[:subir_archivo].present?
      if params[:subir_archivo] == "ok";
         @mensaje = "El archivo ha sido subido exitosamente.";
      else
         @mensaje = "El archivo no ha podido ser subido.";
      end
   end
   #Verificamos si existe la variable eliminar_archivo por GET.
   if params[:eliminar_archivo].present?
      if params[:eliminar_archivo] == "ok";
         @mensaje = "El archivo ha sido eliminado exitosamente";
      else
         @mensaje = "El archivo no ha podido ser eliminado.";
      end
   end
   #Verifica si existe el archivo de los logs.
   if File.exist?(Ruta_archivo_logs)
      @logs = File.read(Ruta_archivo_logs);
   else
      @logs = "";
   end
 end

  def borrar_archivos
   #Recuperamos el nombre del archivo.
   archivo_a_borrar = params[:archivo_a_borrar];
   #Guardamos la ruta del archivo a eliminar.
   ruta_al_archivo = Ruta_directorio_archivos + archivo_a_borrar;
   #Verificamos que el archivo exista para eliminarlo.
   if File.exist?(ruta_al_archivo)
      #Si el archivo existe se intentar� eliminarlo. Dentro de la variable resultado se guardar� true si se pudo eliminar y false si no.
      resultado = File.delete(ruta_al_archivo);
   else
      #El archivo no existe as� que no se pudo eliminar nada.
      resultado = false;
   end
   #Verifica si el archivo se elimin� correctamente.
   if resultado
      eliminar_archivo = "ok";
   else
      eliminar_archivo = "error";
   end
   redirect_to :controller => "archivos", :action => "listar_archivos", :eliminar_archivo => eliminar_archivo;
 end

  def guardar_log
	#Si llega por post intentar� guardar los comentarios que ha ingresado el usuario.
   if request.post?
      #Guarda los comentarios en una variable
      logs = params[:logs];
      #Abre el archivo de logs, Si no existe lo crea, si existe lo sobrescribe
      File.open(Ruta_archivo_logs, "wb"){
         #Alias
         |f|;
         #Escribe el contenido del archivo.
         f.write(logs);
         #Lo cierra para liberar memoria.
         f.close();
      };
   end
   #Verifica si existe el archivo de los comentarios.
   if File.exist?(Ruta_archivo_logs)
      #Guarda el contenido del archivo de los comentarios.
      @logs = File.read(Ruta_archivo_logs);
   else
      #No existe el archivo de los comentarios as� que guarda comillas vac�as en los comentarios.
      @logs = "";
   end
  end
end
