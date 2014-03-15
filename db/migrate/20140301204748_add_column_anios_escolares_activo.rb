class AddColumnAniosEscolaresActivo < ActiveRecord::Migration
  def change
    add_column :anios_escolares, :activo, :integer, :default => 1, :null => false
  end  
end
