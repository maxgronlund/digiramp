class String
  def table_strip
    self.gsub(/(\A\W+)|(\W+\z)/, '')
  end
end