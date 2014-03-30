# encoding: utf-8
class UsuarioMailer < ActionMailer::Base
  default :from => "Administrador MiCole <micole.sistema@gmail.com>"

  def restaurar_clave(usuario, nueva_clave)
    @usuario = usuario
    @nueva_clave = nueva_clave
    attachments.inline["logo_small.jpg"] = File.read("#{Rails.root}/public/logo_small.jpg")
    
    mail(:to => "#{usuario.nombre} <#{usuario.correo}>", :subject => "Restauración de contraseña")
  end
end
