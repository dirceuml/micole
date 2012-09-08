class EventoMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole@gmail.com>"

  def notificacion_evento(evento)
    @evento = evento
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    PersonaVinculada.receptores_notificacion_evento(evento.id).find_each do |p|
      mail(:to => "#{p.apellidos_nombres} <#{p.correo}>", :subject => "Evento: #{TipoEvento.find(evento.tipo_evento_id).descripcion}")
    end
#    mail(:to => "Dirceu <dirceu.ml@gmail.com>", :subject => "Evento: #{TipoEvento.find(evento.tipo_evento_id).descripcion}")
  end
end