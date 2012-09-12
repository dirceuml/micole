# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Micole::Application.initialize!

#require "../../app/overrides/all"

DIAS_SEMANA = %w[Domingo Lunes Martes Miercoles Jueves Viernes Sabado]
DIAS_SEMANA_ABR = %w[Dom Lun Mar Mie Jue Vie Sab]
DIAS_SEMANA_ABR_1 = %w[D L M M J V S]