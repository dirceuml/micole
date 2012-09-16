class TipoEvento < ActiveRecord::Base
  has_many :cuaderno_controles_eventos
  has_many :actividades
end
