class ApplicationController < ActionController::Base

  protect_from_forgery
  
  helper_method :current_user
  helper_method :colegio
  helper_method :anio_escolar
  helper_method :dias_expiracion_clave
  helper_method :dias_aviso_expiracion_clave
  helper_method :dias_restantes_expiracion_clave

  private

  def current_user
    @current_user ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
  end
  
  def colegio
    @colegio ||= Colegio.find(session[:colegio_id]) if session[:colegio_id]
  end
  
  def anio_escolar
    @anio_escolar ||= AnioEscolar.find(session[:anio_escolar_id]) if session[:anio_escolar_id]
  end
  
  def dias_expiracion_clave
    @dias_expiracion_clave = 60
  end
  
  def dias_aviso_expiracion_clave
    @dias_aviso_expiracion_clave = 5
  end
  
  def dias_restantes_expiracion_clave
    user = Usuario.find(session[:usuario_id])
    
    fecha_expiracion = user.fecha_clave + dias_expiracion_clave
    
    @dias_restantes_expiracion_clave = (fecha_expiracion - Date.current).to_i      
  end
end
