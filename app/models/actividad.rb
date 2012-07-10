class Actividad < ActiveRecord::Base
  belongs_to :anio_escolar
  belongs_to :tipo_evento
  has_many :autorizaciones
  
  validates :anio_escolar_id, :tipo_evento_id, :fecha_hora_inicio, :fecha_hora_fin, :presence => true
  validates :tipo_actividad, :nombre, :detalle, :requiere_autorizacion, :usuario, :presence => true
end
