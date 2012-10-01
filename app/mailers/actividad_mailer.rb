class ActividadMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole@gmail.com>"

  def notificacion_actividad(actividad, persona)
    @actividad = actividad
    @persona = persona
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.apellidos_nombres} <#{persona.correo}>", :subject => "Recordatorio de actividad: #{actividad.nombre}")
  end
end
