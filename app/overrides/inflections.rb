# Extender la clase Inflector
module Inflector
  def pluralize(word)
    result = word.to_s.dup

    if word.empty? || inflections.uncountables.include?(result.downcase)
      result
    else
      inflections.plurals.each { |(rule, replacement)| result.gsub!(rule, replacement) }
      result
    end
  end
  
  def singularize(word)
    result = word.to_s.dup
    if inflections.uncountables.include?(result.downcase)
      result
    else
      inflections.singulars.each { |(rule, replacement)| result.gsub!(rule, replacement) }
      result
    end
  end
end


