class TipoEvento < ActiveRecord::Base
  has_many :cuaderno_controles_eventos
  has_many :actividades
  
  validates :descripcion, :alcance, :presence => { :message => ": El campo no puede estar vacio" }
  validates :descripcion, :uniqueness => { :scope => :colegio_id, :message => ": Este evento ya esta registrado" }
  
  scope :por_colegio, lambda { |colegio| where("colegio_id = ?", colegio)}
end
