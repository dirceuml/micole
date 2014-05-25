class TardanzaMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole@gmail.com>"

  def notificacion_tardanza(alumno, persona, horanotificacion)
    @alumno = alumno
    @persona = persona
    @horanotificacion = horanotificacion
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.apellidos_nombres} <#{persona.correo}>", :subject => "Tardanza del alumno(a) #{alumno.apellidos_nombres}")
  end
end
