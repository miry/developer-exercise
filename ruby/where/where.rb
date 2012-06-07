module WhereExtension
  def where(conditions={})
    result = self.dup
    conditions.each do |key, val|
      result.reject!{|item| !item.is_a?(Hash) || !item.has_key?(key) || !(val.is_a?(Regexp) ? item[key] =~ val : item[key] == val) }
    end
    result
  end
end

class Array
  include WhereExtension
end