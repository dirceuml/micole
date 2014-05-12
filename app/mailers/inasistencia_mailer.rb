class InasistenciaMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole@gmail.com>"

  def notificacion_inasistencia(alumno, persona, horanotificacion)
    @alumno = alumno
    @persona = persona
    @horanotificacion = horanotificacion
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.apellidos_nombres} <#{persona.correo}>", :subject => "Inasistencia del alumno(a) #{alumno.apellidos_nombres}")
  end
end
