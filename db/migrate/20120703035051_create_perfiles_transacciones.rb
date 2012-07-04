class CreatePerfilesTransacciones < ActiveRecord::Migration
  def change
    create_table :perfiles_transacciones do |t|
      t.integer :perfil_id
      t.integer :transaccion_id

      t.timestamps
    end
  end
end
