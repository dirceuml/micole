class AlterTypeColumnRevision < ActiveRecord::Migration
  def change
    remove_column :cuaderno_controles_revisiones, :revisado
    add_column :cuaderno_controles_revisiones, :revisado, :integer, :default => 0, :null => false
  end
end
