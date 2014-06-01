class AlterNotaAddFechaNota < ActiveRecord::Migration
  def change
    add_column :notas, :fecha_nota, :date, :null => false
  end  
end
