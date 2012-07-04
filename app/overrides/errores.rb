module ActiveRecord
  class Errors
    begin
      @@default_error_messages = {
        :inclusion => "no está incluido en la lista",
        :exclusion => "está reservado",
        :invalid => "no es válido",
        :confirmation => "no es una confirmación",
        :accepted  => "debe ser aceptado",
        :empty => "no puede estar vacío",
        :blank => "no puede estar en blanco",
        :too_long => "es demasiado largo (máximo %d caracteres)",
        :too_short => "es demasiado corto (mínimo %d caracteres)",
        :wrong_length => "no tiene la longitud correcta (debería tener %d caracteres)",
        :taken => "ya ha sido incluido",
        :not_a_number => "debe ser un número" }
    end
  end
end

module ActionView #nodoc
  module Helpers
    module ActiveRecordHelper
      def error_messages_for(object_name, options = {})
        options = options.symbolize_keys
        object = instance_variable_get("@#{object_name}")
        unless object.errors.empty?
          content_tag("div", content_tag(options[:header_tag] || "h2", "Hay errores que impiden guardar el registro") +
          content_tag("p", "Compruebe los siguientes campos:") +
          content_tag("ul", object.errors.full_messages.collect { |msg| content_tag("li", msg) }), "id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation" )
        end
      end
    end
  end
end