class ListaValor < ActiveRecord::Base
  
  validates :tabla, :item, :descripcion, :presence => { :message => ": El campo no puede estar vacio" }
  validates :item, :uniqueness => { :scope => :tabla, :message => ": Este item ya esta registrado para esta variable" }
  validates :descripcion, :uniqueness => { :scope => :tabla, :message => ": Esta descripcion ya esta registrado para esta variable" }
  scope :detalle, lambda {|tabla| where("tabla = ?", tabla)}
  
end
