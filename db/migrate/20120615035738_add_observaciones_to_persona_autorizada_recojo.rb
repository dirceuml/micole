class AddObservacionesToPersonaAutorizadaRecojo < ActiveRecord::Migration
  def change
    add_column :persona_autorizada_recojos, :Observaciones, :Text

  end
end
