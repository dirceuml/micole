class AlterActividadEstadoDefault < ActiveRecord::Migration
  def self.up
    change_table :actividades do |t|
      t.change :estado, :integer, :default => 1
    end
  end
  def self.down
    change_table :actividades do |t|
      t.change :estado, :integer, :default => 0
    end
  end
end
