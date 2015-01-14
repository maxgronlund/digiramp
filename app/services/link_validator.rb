class LinkValidator
  
  def self.validate link
    link = link.gsub('www.', '')
    link = link.gsub('http://', '')
    link = link.gsub('https://', '')
    return 'http://' + link
  end
  
  
  
end

# usage
#  LinkValidator.validate "somelink.com"
