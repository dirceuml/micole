class ChangeDataTypeForTipoEventoNotificacionInmediata < ActiveRecord::Migration
  def change
    remove_column :tipos_eventos, :notificacion_inmediata
    remove_column :tipos_eventos, :cuaderno_control
    add_column :tipos_eventos, :notificacion_inmediata, :integer, :default => 0, :null => false
    add_column :tipos_eventos, :cuaderno_control, :integer, :default => 0, :null => false
    
  end
end
