class UsuarioMailer < ActionMailer::Base
  default :from => "Administrador MiCole <sistema.micole.adm@gmail.com>"

  def notificacion_credencial(persona)
    @persona = persona
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{persona.nombre} <#{persona.correo}>", :subject => "Acceso al sistema MiCole")
  end
end