class EmailSanitizer
  
  def self.validate email
    /\A([^@\s]+)@((?:(?!-)[-a-z0-9]+(?<!-)\.)+[a-z]{2,})\z/.match(email).nil? ? false : true
  end
  
  def self.saintize email
   
    if email.instance_of? String 
      email = email.strip.gsub(/\s+/, ' ').downcase.gsub(' ', '').gsub(',', '')
      return email if validate email
    end
    false
  end
  
end

# usage
#  EmailSanitizer.validate "olivergale@gmail.com"
# EmailSanitizer.saintize "olivergale@gmail.com"

# .strip.gsub(/\s+/, ' ')