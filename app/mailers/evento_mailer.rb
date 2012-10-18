class EventoMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole.adm@gmail.com>"

  def notificacion_evento(evento, persona)
    @evento = evento
    @persona = persona
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.apellidos_nombres} <#{persona.correo}>", :subject => "Evento: #{TipoEvento.find(evento.tipo_evento_id).descripcion}")
  end
end