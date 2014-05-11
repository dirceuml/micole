# encoding: utf-8
class AsistenciaMailer < ActionMailer::Base
  default :from => "Administrador MiCole <micole.sistema@gmail.com>"  

  def notificar_asistencia(movimiento, alumno, marcacion, persona)
    @movimiento = movimiento     # movimiento = 1 ingreso. movimiento = 2 salida
    @alumno     = alumno
    @marcacion  = marcacion
    @persona    = persona
    if movimiento == 1
      asunto = "Ingreso al colegio"
    else
      asunto = "Salida del colegio"
    end
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.apellidos_nombres} <#{persona.correo}>", :subject => asunto)
  end 
end
