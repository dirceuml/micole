class InasistenciaActividadMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole@gmail.com>"

  def notificacion_inasistencia_actividad(alumno, persona, actividad, horanotificacion)
    @alumno    = alumno
    @persona   = persona
    @actividad = actividad
    @horanotificacion = horanotificacion
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.apellidos_nombres} <#{persona.correo}>", :subject => "Inasistencia a la actividad del alumno(a) #{alumno.apellidos_nombres}")
  end
end
