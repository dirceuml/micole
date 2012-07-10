class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :descripcion, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :cursos, [:descripcion], :name => "ak_cursos_descripcion", :unique => true
  end
end
