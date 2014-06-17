class Array
  def all_except_last
    self[0...-1]
  end
  
  def all_except_first
    self[1..-1]
  end
  
  def all_except_first_and_last
    self[1...-1]
  end
end