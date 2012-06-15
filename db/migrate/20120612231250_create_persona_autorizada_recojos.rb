class CreatePersonaAutorizadaRecojos < ActiveRecord::Migration
  def change
    create_table :persona_autorizada_recojos do |t|
      t.integer :CodigoPersonaAutorizada
      t.integer :CodigoColegio
      t.integer :TipoDocumento
      t.string :NumeroDocumento
      t.string :Nombres
      t.string :ApellidoPaterno
      t.string :ApellidoMaterno
      t.string :Foto

      t.timestamps
    end
  end
end
