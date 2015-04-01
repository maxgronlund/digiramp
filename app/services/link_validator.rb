class LinkValidator
  
  def self.validate link
    if link.to_s != ''
      link = link.gsub('www.', '')
      link = link.gsub('WWW.', '')
      return 'http://' + link
    else
      return ''
    end
  end
  
  def self.sanitize link
    return link.gsub('www.', 'http://') if link.start_with?('www.')
    return link.gsub('WWW.', 'http://')  if link.start_with?('WWW.') 
    link
  end
  
  
  
end

# usage
#  LinkValidator.validate "somelink.com"
