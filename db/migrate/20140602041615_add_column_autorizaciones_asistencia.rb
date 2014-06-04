class AddColumnAutorizacionesAsistencia < ActiveRecord::Migration
  def change
    add_column :autorizaciones, :asistencia, :integer, :null => true
  end
end
