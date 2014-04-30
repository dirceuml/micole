class SessionsController < ApplicationController
  skip_authorize_resource
  
  def new
  end
  
  def create
    user = Usuario.authenticate(params[:usuario], params[:clave])
    if user
      session[:usuario_id] = user.id
      session[:colegio_id] = user.colegio_id
      session[:anio_escolar_id] = AnioEscolar.id_activo
      
      if dias_restantes_expiracion_clave <= dias_aviso_expiracion_clave
        redirect_to expiracion_clave_path(:id => user.id) 
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
    session[:colegio_id] = nil
    session[:anio_escolar_id] = nil
        
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
