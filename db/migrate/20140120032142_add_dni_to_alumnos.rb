class AddDniToAlumnos < ActiveRecord::Migration
  def change
    add_column :alumnos, :dni, :string
  end
end
