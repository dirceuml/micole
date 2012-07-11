class AddForeignKey2 < ActiveRecord::Migration
  def change
    ##
    add_index :cuaderno_controles_eventos, [:cuaderno_control_id], :name => "fk_cuacontrolevento_cuacontrol"
    
    execute "Alter Table \"cuaderno_controles_eventos\" Add Constraint fk_cuacontrolevento_cuacontrol Foreign Key (cuaderno_control_id) References \"cuadernos_controles\"";
    
    ##
    add_index :cuaderno_controles_revisiones, [:cuaderno_control_id], :name => "fk_cuacontrolrevis_cuacontrol"
    
    execute "Alter Table \"cuaderno_controles_revisiones\" Add Constraint fk_cuacontrolrevis_cuacontrol Foreign Key (cuaderno_control_id) References \"cuadernos_controles\"";
    execute "Alter Table \"cuaderno_controles_revisiones\" Add Constraint fk_cuacontrolrevision_alumno Foreign Key (alumno_id) References \"alumnos\"";
    
  end
end
