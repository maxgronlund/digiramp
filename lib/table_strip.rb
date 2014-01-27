# encoding: utf-8


class String
  def table_strip
    self.gsub("\t", '').gsub("\n", '').gsub(/\s+/, ' ').gsub(' ', '').strip
    #self.gsub(/(\A\W+)|(\W+\z)/, '')
  end
end