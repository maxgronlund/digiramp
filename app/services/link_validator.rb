class LinkValidator
  
  def self.validate link
    if link.to_s != ''
      link = link.gsub('www.', '')
      link = link.gsub('http://', '')
      link = link.gsub('https://', '')
      return 'http://' + link
    else
      return ''
    end
  end
  
  
  
end

# usage
#  LinkValidator.validate "somelink.com"
