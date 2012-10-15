scheduler = Rufus::Scheduler.start_new

#scheduler.every("1m") do
#scheduler.cron '0 10 * * * Etc/GMT-5' do
scheduler.cron '0 20 * * *' do
  # todos los días a las 10:00 en GMT-5 
  Actividad.pendiente(Date.current).find_each do |a|
    a.enviar_recordatorio
    puts "Funciona..."
  end
#  puts "Funciona"
end

#scheduler.join