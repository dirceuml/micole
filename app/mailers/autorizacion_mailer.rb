class AutorizacionMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole@gmail.com>"

  def notificacion_autorizacion(actividad, alumno, persona)
    @actividad = actividad
    @alumno = alumno
    @persona = persona
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.apellidos_nombres} <#{persona.correo}>", :subject => "Solicitud de autorizacion para actividad: #{actividad.nombre}")
  end
#  handle_asynchronously :notificacion_autorizacion, :run_at => Proc.new { 2.minutes.from_now }
end
