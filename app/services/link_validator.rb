# when users can type in a link to an external page
# it needs to be prefixed with 'http'
# usage
# LinkValidator.sanitize "somelink.com"

class LinkValidator
  def self.sanitize link
    return link if link.blank?
    return link.downcase.sub('www.', 'http://') if link.downcase.start_with?('www.') 
    link
  end
end