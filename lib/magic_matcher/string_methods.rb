module MagicMatcher::StringMethods
  def without_spaces string
    string.gsub /\s/i, ''
  end
  
  def underscores_as_spaces string
    string.gsub '_', ''
  end
  
  def numbers string
    #string.scan /\d+\.?\,?\d*/
    string.scan /\d+/
  end
  
  def seperators_as_spaces string
    string.gsub /\-|\_/, ''
  end

  def without_ext string
    File.basename string, '.*'
  end
  
  def letters_only string
    string.gsub(/[^a-zA-Z]/, '')
  end
  
  def has_spaces? string
    string.match /\s/
  end
  ## Given two strings s and t it returns the string which contains within it the other string
  ## If the strings don't match each other nil is returned
  def container s, t
    if s.include? t
      return s
    elsif t.include? s
      return t
    end
  end
end