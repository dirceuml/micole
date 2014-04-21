class CuadernoControlRevision < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :persona_vinculada
  belongs_to :alumno
  
  validates :cuaderno_control_id, :alumno_id, :persona_vinculada_id, :revisado, :usuario, :presence => { :message => ": El campo no puede estar vacio" } 
  
  scope :revisado, where(:revisado => 1)
  scope :no_revisado, where(:revisado => 0)
  scope :cerrado, lambda { |anioescolar| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and cuadernos_controles.estado = 2", anioescolar)}
  scope :abierto, lambda { |anioescolar| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and cuadernos_controles.estado = 1", anioescolar)}  
  scope :se_revisan_por, lambda { |padre| joins(:alumno => :alumnos_personas_vinculadas).where("revisa_control = 1 and alumnos_personas_vinculadas.persona_vinculada_id = ?", padre) }
  scope :verificar, lambda { |seccion,fecha| joins(:cuaderno_control).where("estado = 2 and seccion_id = ? and fecha = ?", seccion, fecha)}
end
