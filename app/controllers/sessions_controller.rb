class SessionsController < ApplicationController
  skip_authorize_resource
  
  def new
  end
  
  def create
    user = Usuario.authenticate(params[:usuario], params[:clave])
    if user
      session[:usuario_id] = user.id
      
      dias_transcurridos = (Date.current - user.fecha_clave).to_i
      dias_expiracion = 60
      dias_aviso = 5
      
      if dias_transcurridos >= (dias_expiracion - dias_aviso)
        dias_restantes = dias_expiracion - dias_transcurridos
        redirect_to expiracion_clave_path(:id => user.id, :dias => dias_restantes)
      else
        redirect_to menu_path
      end           
    else
      flash.now.alert = "Usuario o clave invalidos"
      render "new"
    end
  end

  def destroy
    session[:usuario_id] = nil
    redirect_to root_url #, :notice => "Cerro sesion!"
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to root_url, :alert => exception.message
    end
  end
end
