class TipoEvento < ActiveRecord::Base
  has_many :cuaderno_controles_eventos
  has_many :actividades
  
  validates :descripcion, :alcance, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :por_colegio, where("colegio_id = ?", 1)
end
