class AddColumnActividadesEstadoObservacion < ActiveRecord::Migration
  def change
    add_column :actividades, :estado, :integer, :default => 0, :null => false
    add_column :actividades, :observacion, :string, :limit => 50, :null => true
  end
end
