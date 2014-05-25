scheduler = Rufus::Scheduler.new

scheduler.every("24h") do
  # se ha creado pendiente_colegios para seleccionar las actividades pendientes en los años escolares activos de todos los colegios
  Actividad.pendiente_colegios(Date.current).find_each do |a|
    puts "Enviando recordatorio de actividad #{a.id}..."
    a.enviar_recordatorio    
  end
end


# Tareas desactivadas 25/05/2014, porque se esta notificando las inasistencias a los padres al momento de su registro
# 
# Procesa las inasistencias en los años escolares activos de todos los colegios en 3 momentos segun configuracion de cada colegio
# Como no existe tabla de feriados para no enviar notificacion por inasistencia esos dias, se ha cambiado la logica: 
# basta que se registre una asistencia por seccion para que a los alumnos que no registraron marcacion se les envie la notificacion
# 
# todos los dias de la semana a las 10:00, hora de Lima
#scheduler.cron '0 10 * * 1-5 America/Lima' do
#  @asistencia_anio_escolar_seccion = AnioAlumno.asistencia_fecha_notificarinasistencia(Date.current, 3).pluck('DISTINCT anio_escolar_id, seccion_id')
#  @asistencia_anio_escolar_seccion.each do |anio_escolar_seccion|
#    # Por revisar: creo que buscar inasistencia por anio escolar y seccion demora mas que ejecutar una sola consulta.
#    AnioAlumno.inasistencia_anio_escolar_seccion_fecha(anio_escolar_seccion.anio_escolar_id, anio_escolar_seccion.seccion_id, Date.current).find_each do |a|
#      if a.estado == 1   # Estado activo del estudiante en el año escolar
#        puts "Procesando notificacion de asistencia, id #{a.id}..."
#        a.enviar_inasistencia("10:00")
#      end
#    end
#  end
#end
#
## todos los dias de la semana a las 09:15, hora de Lima
#scheduler.cron '15 9 * * 1-5 America/Lima' do
#  @asistencia_anio_escolar_seccion = AnioAlumno.asistencia_fecha_notificarinasistencia(Date.current, 2).pluck('DISTINCT anio_escolar_id, seccion_id')
#  @asistencia_anio_escolar_seccion.each do |anio_escolar_seccion|
#    AnioAlumno.inasistencia_anio_escolar_seccion_fecha(anio_escolar_seccion.anio_escolar_id, anio_escolar_seccion.seccion_id, Date.current).find_each do |a|
#      if a.estado == 1   # Estado activo del estudiante en el año escolar
#        puts "Procesando notificacion de asistencia, id #{a.id}..."
#        a.enviar_inasistencia("09:15")
#      end
#    end
#  end
#end
#
## todos los dias de la semana a las 08:30, hora de Lima
#scheduler.cron '30 8 * * 1-5 America/Lima' do
#  @asistencia_anio_escolar_seccion = AnioAlumno.asistencia_fecha_notificarinasistencia(Date.current, 1).pluck('DISTINCT anio_escolar_id, seccion_id')
#  @asistencia_anio_escolar_seccion.each do |anio_escolar_seccion|
#    AnioAlumno.inasistencia_anio_escolar_seccion_fecha(anio_escolar_seccion.anio_escolar_id, anio_escolar_seccion.seccion_id, Date.current).find_each do |a|
#      if a.estado == 1   # Estado activo del estudiante en el año escolar
#        puts "Procesando notificacion de asistencia, id #{a.id}..."
#        a.enviar_inasistencia("08:30")
#      end
#    end
#  end
#end

#todos los dias de la semana a las 10:40, hora de Lima
#scheduler.cron '40 10 * * 1-5 America/Lima' do
#  puts "Funciona..."
#end


#scheduler.join