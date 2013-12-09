class TipoEvento < ActiveRecord::Base
  has_many :cuaderno_controles_eventos
  has_many :actividades
  
  validates :descripcion, :alcance, :presence => { :message => ": El campo no puede estar vacio" }
  
end
