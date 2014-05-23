class AddColumnUsuariosEstado < ActiveRecord::Migration
  def change
    add_column :usuarios, :estado, :integer, :default => 1, :null => false
  end
end
