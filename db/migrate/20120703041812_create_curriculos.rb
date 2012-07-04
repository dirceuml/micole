class CreateCurriculos < ActiveRecord::Migration
  def change
    create_table :curriculos do |t|
      t.integer :grado_id
      t.integer :curso_id

      t.timestamps
    end
  end
end
