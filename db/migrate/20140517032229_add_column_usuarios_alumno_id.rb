class AddColumnUsuariosAlumnoId < ActiveRecord::Migration
  def change
    add_column :usuarios, :alumno_id, :integer, :null => true
  end
end
