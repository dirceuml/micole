class Grado < ActiveRecord::Base
  belongs_to :anio_escolar
  has_many :secciones
  has_many :curriculos
  has_many :cursos, :through => :curriculos
  
  validates :grado, :usuario, :nivel, :presence => { :message => ": El campo no puede estar vacio" }
  validates :grado, :numericality => { :only_integer => true, :message => ": El campo no es un numero" }
  validates :grado, :uniqueness => { :scope => :anio_escolar_id, :scope => :nivel, :message => ": Este grado ya esta registrado para ese nivel" }

  validate :if => "grado < 0" do |a|
    if a.grado < 0
      errors[:base] << "El grado no puede ser negativo"
    end
  end 
  
  scope :por_anio_escolar, lambda { |anioescolar| where("grados.anio_escolar_id = ?", anioescolar)}
  
  def nivel_desc
    ListaValor.find_by_tabla_and_item(9, nivel).descripcion
  end
  
  def grado_nivel
    grado.to_s + " " + nivel_desc
  end
end
