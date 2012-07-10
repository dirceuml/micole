class Seccion < ActiveRecord::Base
  belongs_to :grado
  
  validates :seccion, :usuario, :presence => true
  
  def grado_seccion
    grado.grado.to_s + " " + seccion
  end
end
