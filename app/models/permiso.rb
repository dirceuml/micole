class Permiso < ActiveRecord::Base
  has_many :perfiles_permisos
  has_many :perfiles, :through => :perfiles_permisos
  
  validates :action, :subject_class, :presence => { :message => ": El campo no puede estar vacio" }
  validates :action, :uniqueness => { :scope => :subject_class, :message => ": Esta accion ya esta registrado para esta clase" }
  
  def detalle
    subject_class + ": " + action
  end
      
end
