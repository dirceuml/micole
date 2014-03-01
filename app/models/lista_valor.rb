class ListaValor < ActiveRecord::Base
  
  validates :tabla, :item, :descripcion, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :detalle, lambda {|tabla| where("tabla = ?", tabla)}
  
end
