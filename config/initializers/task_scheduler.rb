scheduler = Rufus::Scheduler.new

scheduler.every("24h") do
  # se ha creado pendiente_colegios para seleccionar las actividades pendientes en los años escolares activos de todos los colegios
  Actividad.pendiente_colegios(Date.current).find_each do |a|
    a.enviar_recordatorio
#    puts "Funciona..."
  end
end


scheduler.cron '0 10 * * 1-5 America/Lima' do
  # todos los dias de la semana a las 10:00, hora de Lima
  # Procesa las inasistencias en los años escolares activos de todos los colegios
  AnioAlumno.inasistencia_fecha(Date.current).find_each do |a|
    a.enviar_inasistencia    
  end
end

#todos los d�as de la semana a las 10:40, hora de Lima
#scheduler.cron '40 10 * * 1-5 America/Lima' do
#  puts "Funciona..."
#end


#scheduler.join