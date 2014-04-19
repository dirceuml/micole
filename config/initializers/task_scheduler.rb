scheduler = Rufus::Scheduler.new

scheduler.every("36h") do
#scheduler.cron '0 10 * * * Etc/GMT-5' do
#scheduler.cron '0 15 * * *' do
  # todos los días a las 10:00 en GMT-5 
  Actividad.pendiente(anio_escolar.id, Date.current).find_each do |a|
    a.enviar_recordatorio
#    puts "Funciona..."
  end
end


scheduler.cron '30 30 1 * * 1-5' do
  # todos los dias de la semana a las 10:00 en GMT-5 
  AnioAlumno.inasistencia_fecha(anio_escolar.id, Date.current).find_each do |a|
    a.enviar_inasistencia    
  end
end

#scheduler.join