scheduler = Rufus::Scheduler.start_new

scheduler.every("36h") do
#scheduler.cron '0 10 * * * Etc/GMT-5' do
#scheduler.cron '0 15 * * *' do
  # todos los días a las 10:00 en GMT-5 
  Actividad.pendiente(Date.current).find_each do |a|
    a.enviar_recordatorio
#    puts "Funciona..."
  end
end

#scheduler.join
  # todos los días a las 10:00 en GMT-5 
  AnioAlumno.inasistencia_fecha(Date.current).find_each do |a|
    a.enviar_inasistencia
  end
end