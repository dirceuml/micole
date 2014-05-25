class AddColumnControlesAsistenciasFecha < ActiveRecord::Migration
  def change
    add_column :controles_asistencias, :fecha, :date, :null => false
  end  
end
