# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Micole::Application.initialize!

#require "../../app/overrides/all"

DIAS_SEMANA = %w[~ Lunes Martes Miercoles Jueves Viernes Sabado Domingo]
DIAS_SEMANA_ABR = %w[~ Lun Mar Mie Jue Vie Sab Dom]
DIAS_SEMANA_ABR_1 = %w[~ L M M J V S D]

MESES = %w[~ Enero Febrero Marzo Abril Mayo Junio Julio Agosto Setiembre Octubre Noviembre Diciembre]
MESES_ABR = %w[~ Ene Feb Mar Abr May Jun Jul Ago Set Oct Nov Dic]