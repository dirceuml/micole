class AddNivelToGrados < ActiveRecord::Migration
  def change
    add_column :grados, :nivel, :integer, :default => 1, :null => false
  end
end
