class AlterCuadernoControlesRevisionesPersona < ActiveRecord::Migration
  def change
    change_column :cuaderno_controles_revisiones, :persona_vinculada_id, :integer, :null => true
  end
end
