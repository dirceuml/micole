class AddColumnColegiosEstado < ActiveRecord::Migration
  def change
    add_column :colegios, :estado, :integer, :default => 1, :null => false
  end  
end
