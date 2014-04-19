class AnioEscolar < ActiveRecord::Base
  has_many :grados
  has_many :tipos_notas
  has_many :anios_alumnos
  has_many :alumnos, :through => :anios_alumnos
  has_many :actividades
  
  belongs_to :colegio
  
  validates :colegio_id, :anio, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :anio, :uniqueness => {:scope => :colegio_id, :message => "Solamente se puede configurar un periodo por colegio"}
  
  scope :anioescolarcolegio, where("anios_escolares.colegio_id = ?", 1)
  
  validate :if => "!anio.nil?" do |a|
    if a.anio > Time.now.year
      errors[:base] << "No esta dentro del tiempo permitido para aperturar"
    end
  end
  
  def self.id_activo
    anio = AnioEscolar.find_by_activo(1)
    
    if !anio.nil?
      anio.id
    else
      nil
    end
  end

end
