class CuadernoControl < ActiveRecord::Base
  has_many :cuaderno_controles_eventos, :dependent => :delete_all
  has_many :cuaderno_controles_revisiones #, :dependent => :delete_all
  belongs_to :seccion
  
  validates :seccion_id, :fecha, :estado, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :fecha, :uniqueness => {:scope => :seccion_id, :message => "Solamente se puede haber un registro por fecha y seccion"} 
  
  scope :cerrado, where(:estado => 2)
  scope :abierto, where(:estado => 1)
end
