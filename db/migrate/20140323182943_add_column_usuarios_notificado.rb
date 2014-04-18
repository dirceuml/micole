class AddColumnUsuariosNotificado < ActiveRecord::Migration
 def change
    add_column :usuarios, :notificado, :integer, :default => 0, :null => false
  end
end
