class Permiso < ActiveRecord::Base
  has_many :perfiles_permisos
  has_many :perfiles, :through => :perfiles_permisos
  
  def detalle
    subject_class + ": " + action
  end
      
end
