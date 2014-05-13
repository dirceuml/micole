class CreateUsuariosSecciones < ActiveRecord::Migration
  def change
    create_table :usuarios_secciones do |t|
      t.integer :usuario_id, :null => false
      t.integer :seccion_id, :null => false
      t.integer :verifica_cuaderno_control, :null => false, :default => 0, :inclusion => { :in => [0,1] }
      t.integer :asigna_actividad, :null => false, :default => 0, :inclusion => { :in => [0,1] }
      t.integer :revisa_autorizacion, :null => false, :default => 0, :inclusion => { :in => [0,1] }
      t.integer :revisa_asistencia, :null => false, :default => 0, :inclusion => { :in => [0,1] }
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :usuarios_secciones, [:usuario_id, :seccion_id], :name => "ak_usuarios_secciones", :unique => true
    add_index :usuarios_secciones, [:usuario_id], :name => "fk_usuariossecciones_usuario"
    add_index :usuarios_secciones, [:seccion_id], :name => "fk_usuariossecciones_seccion"
    
    execute "Alter Table \"usuarios_secciones\" Add Constraint fk_usuariossecciones_usuario Foreign Key (usuario_id) References \"usuarios\"";
    execute "Alter Table \"usuarios_secciones\" Add Constraint fk_usuariossecciones_seccion Foreign Key (seccion_id) References \"secciones\"";

  end  
end
