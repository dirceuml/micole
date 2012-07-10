class Curriculo < ActiveRecord::Base
  belongs_to :grado
  belongs_to :curso
end
