class Permiso < ActiveRecord::Base
  has_many :perfiles_permisos
  has_many :perfiles, :through => :perfiles_permisos
  
  validates :action, :subject_class, :presence => { :message => ": El campo no puede estar vacio" }
  
  def detalle
    subject_class + ": " + action
  end
      
end
