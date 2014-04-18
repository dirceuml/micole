class AddColumnAniosAlumnosEstado < ActiveRecord::Migration
  def change
    add_column :anios_alumnos, :estado, :integer, :default => 1, :null => false
  end
end
