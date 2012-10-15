scheduler = Rufus::Scheduler.start_new

scheduler.cron '30 1 * * *' do
  # todos los días a las 10:00 en GMT-5 
  Actividad.pendiente(Date.current).find_each do |a|
    a.enviar_recordatorio
    #puts "Funciona..."
  end
end