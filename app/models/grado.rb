class Grado < ActiveRecord::Base
  belongs_to :anio_escolar
  has_many :secciones
  has_many :curriculos
  has_many :cursos, :through => :curriculos
  
  validates :grado, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :grado, :numericality => { :only_integer => true, :message => ": El campo no es un numero" }

  validate :if => "grado < 0" do |a|
    if a.grado < 0
      errors[:base] << "El grado no puede ser negativo"
    end
  end 
  
  scope :anio_escolar, lambda { |anioescolar| where("grados.anio_escolar_id = ?", anioescolar)}
  
end
