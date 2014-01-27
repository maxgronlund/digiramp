class NilClass
  def contains_nothing?
    true
  end
  
  def contains_something?
    false
  end
end
class String
  def contains_nothing?
    strip.empty?
  end
  def contains_something?
    not contains_nothing?
  end
end

class Symbol
  def contains_nothing?
    to_s.contains_nothing?
  end
  def contains_something?
    not contains_nothing?
  end
end

class Array
  def contains_nothing?
    a = dup
    a.delete(nil)
    a.empty?
  end
  
  def contains_something?
    not contains_nothing?
  end
  
  def values_all_contain_nothing?
    each do |v|
      if v.respond_to? :contains_nothing?
        return false unless v.contains_nothing?
      end
    end
    
    return true
  end
end

class Hash
  def contains_nothing?
    empty?
  end
  
  def contains_something?
    not contains_nothing?
  end
  
  def values_all_contain_nothing?
    each do |k, v|
      if v.respond_to? :contains_nothing?
        return false unless v.contains_nothing?
      end
    end
    
    return true
  end
end