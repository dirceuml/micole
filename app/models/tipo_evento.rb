class TipoEvento < ActiveRecord::Base
  has_many :cuaderno_controles_eventos
end
