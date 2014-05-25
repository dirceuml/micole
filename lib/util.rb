# To change this template, choose Tools | Templates
# and open the template in the editor.

module Util
  def first_non_nil(*args)
    for arg in args
      return arg unless arg.nil?
    end

    nil
  end
  
  class Array
 
    # Returns the first non-nil element of self
    def first_non_nil(*args)
      self.each do |element|
        return element unless element.nil?
      end

      nil
    end


    # Alias for the Oracle folks
    def nvl
      first_non_nil
    end


    # Alias for the Postgres folks
    def coalesce
      first_non_nil
    end

  end
end
