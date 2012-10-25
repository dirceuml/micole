class SessionsController < ApplicationController
  skip_authorize_resource
  
  def new
  end
  
  def create
    user = Usuario.authenticate(params[:usuario], params[:clave])
    if user
      session[:usuario_id] = user.id
      redirect_to "/menu" #, :notice => "Logueado!"
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
