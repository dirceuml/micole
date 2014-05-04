class Actividad < ActiveRecord::Base
  belongs_to :anio_escolar
  belongs_to :tipo_evento
  has_many :autorizaciones
  has_many :actividades_secciones
  has_many :secciones, :through => :actividades_secciones
  has_many :alumnos, :through => :secciones
  has_many :personas_vinculadas, :through => :alumnos
  
  validates :anio_escolar_id, :tipo_evento_id, :fecha_hora_inicio, :fecha_hora_fin, :presence => { :message => ": El campo no puede estar vacio" }
  validates :tipo_actividad, :nombre, :detalle, :requiere_autorizacion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  #validates_format_of :hora_min_inicio, :with => /\d{1,2}:\d{2}/, :message => "invalido"
  
  validate :if => "!fecha_hora_inicio.nil? && !fecha_hora_fin.nil?" do |a|
    if !a.fecha_hora_inicio.nil? && !a.fecha_hora_fin.nil?
      if a.fecha_hora_inicio >= a.fecha_hora_fin
        errors[:base] << "Error en rango de fechas de la actividad"
      end
    end
  end
  
  validate :if => "requiere_autorizacion == 1" do |a|
    if a.limite_autorizacion.nil?
      errors[:base] << "Falta ingresar la fecha limite para autorizacion"
    else
      if (a.limite_autorizacion > a.fecha_hora_inicio.to_date)  # || a.limite_autorizacion < a.fecha_hora_inicio.to_date 
        errors[:base] << "Error en la fecha limite para autorizacion"
      end
    end
  end
  
  validate :if => "!inicio_notificacion.nil? || !fin_notificacion.nil?" do |a|
    if !a.inicio_notificacion.nil? || !a.fin_notificacion.nil?
      if a.inicio_notificacion.nil?
        errors[:base] << "Falta ingresar la fecha inicio de notificacion"
      else
         if a.fin_notificacion.nil?
           errors[:base] << "Falta ingresar la fecha fin de notificacion"
         else
           if a.inicio_notificacion > a.fin_notificacion
             errors[:base] << "Error en rango de fechas de notificacion"
           else
             if a.fin_notificacion > a.fecha_hora_inicio.to_date
               errors[:base] << "La fecha fin de notificacion no puede ser posterior al inicio de la actividad"
             else
               if a.frecuencia_dias_notificacion.nil?
                 errors[:base] << "Falta ingresar la frecuencia de notificacion"
               else
                 if a.frecuencia_dias_notificacion < 1 || a.frecuencia_dias_notificacion > 30
                   errors[:base] << "Error en la frecuencia de notificacion (Rango de 1 a 30 dias)"
                 end
               end
             end
           end
         end
      end
    end
  end
    
  scope :pendiente, lambda { |anioescolar, fecha| where("actividades.anio_escolar_id = ? and to_char(fecha_hora_fin, 'yyyymmdd') >= ?", anioescolar, fecha.strftime('%Y%m%d'))}
  scope :realizada, lambda { |anioescolar, fecha| where("actividades.anio_escolar_id = ? and to_char(fecha_hora_fin, 'yyyymmdd') < ?", anioescolar, fecha.strftime('%Y%m%d'))}
  scope :pendiente_colegios, lambda { |fecha| joins(:anio_escolar).where("anios_escolares.activo = 1 and to_char(fecha_hora_fin, 'yyyymmdd') >= ?", fecha.strftime('%Y%m%d'))}
  
  scope :por_fecha_inicio, lambda { |anioescolar, fecha| where("anio_escolar_id = ? and to_char(fecha_hora_inicio, 'dd/mm/yyyy') = ?", anioescolar, fecha.strftime('%d/%m/%Y'))}
  scope :por_seccion, lambda { |anioescolar, seccion| joins(:actividades_secciones).where("anio_escolar_id = ? and actividades_secciones.seccion_id = ?", anioescolar, seccion)}
  scope :por_persona, lambda { |persona| joins(:secciones => {:anios_alumnos => :personas_vinculadas}).uniq.where("personas_vinculadas.id = ?", persona)}
  scope :por_persona_y_fecha, lambda { |persona,fecha| por_persona(persona).where("to_char(fecha_hora_inicio, 'dd/mm/yyyy') = ?", fecha.strftime('%d/%m/%Y'))}
  scope :apoderados, lambda { |actividad| joins(:personas_vinculadas).where("actividades.id = ? and alumnos_personas_vinculadas.apoderado = 1", actividad)}
  
  #attr_accessor :fecha_inicio, :hora_inicio, :min_inicio, :fecha_fin, :hora_fin, :min_fin
  
  #after_initialize :get_datetime_inicio, :get_datetime_fin
  #before_validation :set_datetime_inicio, :set_datetime_fin
  
  #def get_datetime_inicio
  #  if !self.fecha_hora_inicio.nil?
  #    self.fecha_inicio ||= self.fecha_hora_inicio.to_date.to_s(:db)
  #    self.hora_inicio ||= self.fecha_hora_inicio.hour
  #    self.min_inicio  ||= self.fecha_hora_inicio.min
  #  end
  #end
  
  #def get_datetime_fin
  #  if !self.fecha_hora_fin.nil?
  #    self.fecha_fin ||= self.fecha_hora_fin.to_date.to_s(:db)
  #    self.hora_fin  ||= self.fecha_hora_fin.hour
  #    self.min_fin   ||= self.fecha_hora_fin.min
  #  end
  #end
  
  #def set_datetime_inicio
  #  self.fecha_hora_inicio = "#{self.fecha_inicio} #{'%02d' % self.hora_inicio}:#{'%02d' % self.min_inicio}:00"
  #end
  
  #def set_datetime_fin
  #  self.fecha_hora_fin = "#{self.fecha_fin} #{'%02d' % self.hora_fin}:#{'%02d' % self.min_fin}:00"
  #end
  
  def nombre_fecha
     nombre+ " el "+ fecha_hora_inicio.strftime('%d/%m/%Y')
#      to_date.to_s(:db)
  end
  
  def enviar_recordatorio
    if estado == 2 and !inicio_notificacion.nil?
      if inicio_notificacion <= Date.current and fin_notificacion >= Date.current
        alumnos.find_each do |a|
          a.personas_vinculadas.where("apoderado = 1").find_each do |p|
            ActividadMailer.notificacion_actividad(Actividad.find(id), a, p).deliver
          end
        end
      end
    end
  end
  
  def enviar_solicitud_autorizacion
    if estado == 2 and requiere_autorizacion == 1
      alumnos.find_each do |a|
        a.personas_vinculadas.where("apoderado = 1").find_each do |p|
#          AutorizacionMailer.notificacion_autorizacion(Actividad.find(id), a, p).deliver
          AutorizacionMailer.delay.notificacion_autorizacion(Actividad.find(id), a, p) #asincrono, con delayed_job
        end
      end
    end
  end
end
