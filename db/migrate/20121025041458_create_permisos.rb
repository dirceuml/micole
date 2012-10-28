class CreatePermisos < ActiveRecord::Migration
  def change
    create_table :permisos do |t|
      t.string :action, :null => false
      t.string :subject_class, :null => false
      t.integer :subject_id

      t.timestamps
    end
  end
end
