class AnioEscolar < ActiveRecord::Base
  has_many :grados
  has_many :tipos_notas
  has_many :anios_alumnos
  has_many :alumnos, :through => :anios_alumnos
  has_many :actividades
  
  belongs_to :colegio
  
  validates :colegio_id, :anio, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :anio, :uniqueness => {:scope => :colegio_id, :message => "Solamente se puede configurar un periodo por colegio"}
  
  scope :anioescolarcolegio, lambda { |colegio| where("anios_escolares.colegio_id = ?", colegio)}
  
  validate :if => "!anio.nil?" do |a|
    if a.anio > Time.now.year
      errors[:base] << "No esta dentro del tiempo permitido para aperturar"
    end
  end
  
  validate :if => "!inicio_clases.nil? || !fin_clases.nil?" do |a|
    if a.inicio_clases.nil?
      errors.add(:inicio_clases, ": Ingrese la fecha de inicio de clases")
    else
      if a.inicio_clases.year != a.anio
        errors.add(:inicio_clases, ": La fecha de inicio de clases debe estar dentro del periodo escolar")
      else
        if a.fin_clases.nil?
          errors.add(:fin_clases, ": Ingrese la fecha de fin de clases")
        else
          if a.inicio_clases > a.fin_clases
            errors.add(:fin_clases, ": Ingrese correctamente el rango de fechas")
          end
        end
      end
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
