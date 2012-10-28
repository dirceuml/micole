#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Micole::Application.load_tasks


desc "Inicia el worker Scheduler"
task :scheduler => :environment do

  scheduler = Rufus::Scheduler.start_new

#scheduler.every("1m") do
#scheduler.cron '0 10 * * * Etc/GMT-5' do
scheduler.cron '30 1 * * *' do
  # todos los di­as a las 10:00
  Actividad.pendiente(Date.current).find_each do |a|
    a.enviar_recordatorio
    #puts "Funciona..."
  end
end

  scheduler.join
end