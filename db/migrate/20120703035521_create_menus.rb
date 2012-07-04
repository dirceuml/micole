class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :menu_id
      t.integer :transaccion_id
      t.integer :orden

      t.timestamps
    end
  end
end
