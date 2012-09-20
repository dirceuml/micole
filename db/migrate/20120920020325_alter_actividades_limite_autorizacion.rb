class AlterActividadesLimiteAutorizacion < ActiveRecord::Migration
  def change
    remove_column :actividades, :limite_autorizacion
    add_column :actividades, :limite_autorizacion, :date, :null => true
  end
end
