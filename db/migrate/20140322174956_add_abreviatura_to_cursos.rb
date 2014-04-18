class AddAbreviaturaToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :abreviatura, :string
    add_index :cursos, :abreviatura, :name => "idx_curso_abreviatura"
  end
end
