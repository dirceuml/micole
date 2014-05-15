class AddColumnUsuariosAlcanceColegio < ActiveRecord::Migration
  def change
    add_column :usuarios, :alcance_colegio, :integer, :null => true
  end
end
