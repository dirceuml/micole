class AddColumnActividadesAlcanceColegio < ActiveRecord::Migration
  def change
    add_column :actividades, :alcance_colegio, :integer, :null => true
  end
end
