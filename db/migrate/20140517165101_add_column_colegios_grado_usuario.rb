class AddColumnColegiosGradoUsuario < ActiveRecord::Migration
  def change
    add_column :colegios, :grado_usuario, :integer, :null => true
  end
end
