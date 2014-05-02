class AlterIndexAkGrados < ActiveRecord::Migration
  def up
    remove_index :grados, :name => "ak_grados"
    add_index :grados, [:anio_escolar_id , :grado, :nivel], :name => "ak_grados", :unique => true
  end

  def down
    remove_index :grados, :name => "ak_grados"
    add_index :grados, [:anio_escolar_id , :grado], :name => "ak_grados", :unique => true
  end
end
