# encoding: utf-8
class UsuarioMailer < ActionMailer::Base
  default :from => "Administrador MiCole <micole.sistema@gmail.com>"

  def notificar_credencial(usuario, clave, tipo)
    @usuario = usuario
    @clave   = clave
    @tipo    = tipo     # tipo = 1, para nuevo usuario. tipo = 2, restaurar contraseña
    if tipo == 1
      asunto = "Acceso al sistema MiCole"
    else
      asunto = "Restauración de contraseña"
    end
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{usuario.nombre} <#{usuario.correo}>", :subject => asunto)
  end  
end
