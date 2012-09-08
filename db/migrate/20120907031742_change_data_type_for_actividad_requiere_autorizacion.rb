class ChangeDataTypeForActividadRequiereAutorizacion < ActiveRecord::Migration
  def change
    remove_column :actividades, :requiere_autorizacion
    add_column :actividades, :requiere_autorizacion, :integer, :default => 0, :null => false
  end
end
