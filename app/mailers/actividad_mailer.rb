class ActividadMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole.adm@gmail.com>"

  def notificacion_actividad(actividad, alumno, persona)
    @actividad = actividad
    @alumno = alumno
    @persona = persona
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.apellidos_nombres} <#{persona.correo}>", :subject => "Recordatorio de actividad: #{actividad.nombre}")
  end
end
