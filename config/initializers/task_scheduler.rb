scheduler = Rufus::Scheduler.new

scheduler.every("36h") do
#scheduler.cron '0 10 * * * Etc/GMT-5' do
#scheduler.cron '0 15 * * *' do
  # todos los días a las 10:00 en GMT-5
  # se ha creado pendiente_all para seleccionar las actividades pendientes en los años escolares activos de todos los colegios
  Actividad.pendiente_all(Date.current).find_each do |a|
    a.enviar_recordatorio
#    puts "Funciona..."
  end
end


scheduler.cron '30 30 1 * * 1-5' do
  # todos los dias de la semana a las 10:00 en GMT-5 
  # Procesa las inasistencias en los años escolares activos de todos los colegios
  AnioAlumno.inasistencia_fecha(Date.current).find_each do |a|
    a.enviar_inasistencia    
  end
end

#scheduler.join