class ArchivosController < ApplicationController
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
                raise StandardError, "Estructura incorrecta." if line.count("|") != 12
                
                dni, nombres, apellido_paterno, apellido_materno, fecha_nacimiento, telefono_fijo, telefono_movil, direccion, correo, grado_desc, seccion_desc, nivel_abr = line.split("|")
                
                raise StandardError, "Debe especificar un DNI." if dni.nil? || dni.strip == ""
                raise StandardError, "Debe especificar los nombres." if nombres.nil? || nombres.strip == ""
                raise StandardError, "Debe especificar el apellido paterno." if apellido_paterno.nil? || apellido_paterno.strip == ""
                raise StandardError, "Debe especificar el apellido materno." if apellido_materno.nil? || apellido_materno.strip == ""
                raise StandardError, "Debe especificar la fecha de nacimiento." if fecha_nacimiento.nil? || fecha_nacimiento.strip == ""
                raise StandardError, "Debe especificar el grado." if grado_desc.nil? || grado_desc.strip == ""
                raise StandardError, "Debe especificar la seccion." if seccion_desc.nil? || seccion_desc.strip == ""
                raise StandardError, "Debe especificar el nivel." if nivel_abr.nil? || nivel_abr.strip == ""
                
                alumno = Alumno.find_by_dni(dni)

                if !alumno.nil?
                  alumno.update_attributes!(
                    :nombres => nombres,
                    :apellido_paterno => apellido_paterno,
                    :apellido_materno => apellido_materno,
                    :fecha_nacimiento => fecha_nacimiento,
                    :telefono_fijo => telefono_fijo,
                    :telefono_movil => telefono_movil,
                    :direccion => direccion,
                    :correo => correo,
                    :usuario => current_user.usuario
                  )
                else
                  alumno = Alumno.create!(
                    :dni => dni,
                    :nombres => nombres,
                    :apellido_paterno => apellido_paterno,
                    :apellido_materno => apellido_materno,
                    :fecha_nacimiento => fecha_nacimiento,
                    :telefono_fijo => telefono_fijo,
                    :telefono_movil => telefono_movil,
                    :direccion => direccion,
                    :correo => correo,
                    :usuario => current_user.usuario
                  )
                end    
                
                nivel = ListaValor.find_by_tabla_and_abreviatura(9, nivel_abr)
                raise ActiveRecord::RecordNotFound, "Nivel no existe." if nivel.nil?
              
                nivel_cod = nivel.item
              
                grado = Grado.find_by_anio_escolar_id_and_grado_and_nivel(anio_escolar.id, grado_desc, nivel_cod)
                raise ActiveRecord::RecordNotFound, "Grado no encontrado" if grado.nil?
                
                seccion = Seccion.find_by_grado_id_and_seccion(grado.id, seccion_desc)
                raise ActiveRecord::RecordNotFound, "Seccion no encontrada" if seccion.nil?
                
                anio_alumno = AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anio_escolar.id, alumno.id)
                
                if anio_alumno.nil?
                  AnioAlumno.create!(
                    :anio_escolar_id => anio_escolar.id,
                    :alumno_id => alumno.id,
                    :seccion_id => seccion.id,
                    :usuario => current_user.usuario
                  )
                else
                  anio_alumno.update_attributes!(
                    :seccion_id => seccion.id,
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
         redirect_to :controller => "archivos", :action => "cargar_alumnos", :res => res;
      else
         @formato_erroneo = true;
      end
    end
 end
 
  
  def cargar_padres
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
                raise StandardError, "Estructura incorrecta." if line.count("|") != 8
                
                tipo_documento, numero_documento, nombres, apellido_paterno, apellido_materno, telefono_fijo, telefono_movil, correo = line.split("|")

                raise StandardError, "Debe especificar el tipo de documento de identidad." if tipo_documento.nil? || tipo_documento.strip == ""
                raise StandardError, "Debe especificar el numero de documento de identidad." if numero_documento.nil? || numero_documento.strip == ""
                raise StandardError, "Debe especificar los nombres." if nombres.nil? || nombres.strip == ""
                raise StandardError, "Debe especificar el apellido paterno." if apellido_paterno.nil? || apellido_paterno.strip == ""
                raise StandardError, "Debe especificar el apellido materno." if apellido_materno.nil? || apellido_materno.strip == ""
                raise StandardError, "Debe especificar la direccion de correo." if correo.nil? || correo.strip == ""
                
                padre = PersonaVinculada.find_by_tipo_documento_and_numero_documento(tipo_documento, numero_documento)

                if !padre.nil?
                  padre.update_attributes!(
                    :nombres => nombres,
                    :apellido_paterno => apellido_paterno,
                    :apellido_materno => apellido_materno,
                    :telefono_fijo => telefono_fijo,
                    :telefono_movil => telefono_movil,
                    :correo => correo,
                    :user => current_user.usuario,
                    :foto => File.open("#{Rails.root.to_s}/public/foto.jpg")
                  )
                else
                  PersonaVinculada.create!(
                    :tipo_documento => tipo_documento,
                    :numero_documento => numero_documento,
                    :nombres => nombres,
                    :apellido_paterno => apellido_paterno,
                    :apellido_materno => apellido_materno,
                    :telefono_fijo => telefono_fijo,
                    :telefono_movil => telefono_movil,
                    :correo => correo,
                    :foto => "foto.jpg",
                    :user => current_user.usuario,
                    :foto => File.open("#{Rails.root.to_s}/public/foto.jpg"),
                    :origen => "carga"
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
        
         #Redirige al controlador "archivos", a la accion "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subi� el archivo y "error" si no se pudo.
         redirect_to :controller => "archivos", :action => "cargar_padres", :res => res;
      else
         @formato_erroneo = true;
      end
    end
 end
 
  
  
  def cargar_vinculos
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
                raise StandardError, "Estructura incorrecta." if line.count("|") != 4
                
                dni_alumno, tipo_documento_padre, numero_documento_padre, inicio_vigencia = line.split("|")
                
                raise StandardError, "Debe especificar el DNI del alumno." if dni_alumno.nil? || dni_alumno.strip == ""
                raise StandardError, "Debe especificar el tipo de documento de identidad del padre." if tipo_documento_padre.nil? || tipo_documento_padre.strip == ""
                raise StandardError, "Debe especificar el numero de documento de identidad del padre." if numero_documento_padre.nil? || numero_documento_padre.strip == ""
                raise StandardError, "Debe especificar la fecha de inicio de vigencia del vinculo." if inicio_vigencia.nil? || inicio_vigencia.strip == ""

                alumno = Alumno.find_by_dni(dni_alumno)
                raise ActiveRecord::RecordNotFound, "Alumno no encontrado" if alumno.nil?
                
                padre = PersonaVinculada.find_by_tipo_documento_and_numero_documento(tipo_documento_padre, numero_documento_padre)
                raise ActiveRecord::RecordNotFound, "Padre no encontrado" if padre.nil?

                vinculo = AlumnoPersonaVinculada.find_by_persona_vinculada_id_and_alumno_id(padre.id, alumno.id)

                if !vinculo.nil?
                  vinculo.update_attributes!(
                    :persona_vinculada_id => padre.id,
                    :alumno_id => alumno.id,
                    :inicio_vigencia => inicio_vigencia,
                    :usuario => current_user.usuario
                  )
                else
                  AlumnoPersonaVinculada.create!(
                    :persona_vinculada_id => padre.id,
                    :alumno_id => alumno.id,
                    :inicio_vigencia => inicio_vigencia,
                    :tipo_vinculo => 1,
                    :vigencia_vinculo => 2,
                    :apoderado => 1,
                    :autoriza_actividad => 1,
                    :revisa_control => 1,
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
         redirect_to :controller => "archivos", :action => "cargar_vinculos", :res => res;
      else
         @formato_erroneo = true;
      end
    end
 end
 
  
  def cargar_grados_secciones
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
                raise StandardError, "Estructura incorrecta." if line.count("|") != 4
                
                periodo_desc, grado_desc, seccion_desc, nivel_abr = line.split("|")

                raise StandardError, "Debe especificar el periodo escolar." if periodo_desc.nil? || periodo_desc.strip == ""
                raise StandardError, "Debe especificar el grado." if grado_desc.nil? || grado_desc.strip == ""
                raise StandardError, "Debe especificar la seccion." if seccion_desc.nil? || seccion_desc.strip == ""
                raise StandardError, "Debe especificar el nivel." if nivel_abr.nil? || nivel_abr.strip == ""
                
                anio_escolar = AnioEscolar.find_by_anio(periodo_desc)
                raise ActiveRecord::RecordNotFound, "Periodo escolar no creado." if anio_escolar.nil?
                
                nivel = ListaValor.find_by_tabla_and_abreviatura(9, nivel_abr)
                raise ActiveRecord::RecordNotFound, "Nivel no existe." if nivel.nil?
              
                cod_nivel = nivel.item
                grado = Grado.find_by_anio_escolar_id_and_grado_and_nivel(anio_escolar.id, grado_desc, cod_nivel)
                
                if grado.nil?
                  grado = Grado.create!(
                    :anio_escolar_id => anio_escolar.id,
                    :grado => grado_desc,
                    :nivel => cod_nivel,
                    :usuario => current_user.usuario
                  )
                end
                
                seccion = Seccion.find_by_grado_id_and_seccion(grado.id, seccion_desc)
                
                if seccion.nil?
                  seccion = Seccion.create!(
                    :grado_id => grado.id,
                    :seccion => seccion_desc,
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
        
         #Redirige al controlador "archivos", a la accion "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subi� el archivo y "error" si no se pudo.
         redirect_to :controller => "archivos", :action => "cargar_grados_secciones", :res => res;
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

end
