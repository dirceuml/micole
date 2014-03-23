class AddAbreviaturaToTiposNotas < ActiveRecord::Migration
  def change
    add_column :tipos_notas, :abreviatura, :string
    add_index :tipos_notas, :abreviatura, :name => "idx_tiponota_abreviatura"
  end
end
