class TipoNota < ActiveRecord::Base
  belongs_to :anio_escolar
  has_many :notas
  validates :descripcion, :abreviatura, :presence => { :message => ": El campo no puede estar vacio" }
  validates :descripcion, :uniqueness => {:scope => :anio_escolar_id, :message => "El nombre del tipo de nota ya esta registrado. Verifique" }
  validates :abreviatura, :uniqueness => {:scope => :anio_escolar_id, :message => "La abreviatura ya esta registrado. Verifique" }  
  
  scope :por_anio_escolar, lambda { |anioescolar| where("tipos_notas.anio_escolar_id = ?", anioescolar)}
end
