class UsuarioAddFechaClave < ActiveRecord::Migration
  def change
    add_column :usuarios, :fecha_clave, :date
  end
end
