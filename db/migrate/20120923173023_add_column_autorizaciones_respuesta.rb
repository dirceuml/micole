class AddColumnAutorizacionesRespuesta < ActiveRecord::Migration
  def change
    add_column :autorizaciones, :respuesta, :integer, :null => true
  end
end
