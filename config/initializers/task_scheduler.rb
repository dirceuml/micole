scheduler = Rufus::Scheduler.start_new

#scheduler.every("1m") do
#  Actividad.find(5).enviar_recordatorio
#end 

#scheduler.cron '0 10 * * * Etc/GMT-5' do
scheduler.cron '28 23 * * *' do
  # todos los días a las 10:00 en GMT-5
  Actividad.find(5).enviar_recordatorio
end