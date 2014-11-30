class EmailValidator
  
  def self.validate email
    return /^\S+@\S+\.\S+$/.match(email).nil? ? false : true
  end
  
  def self.saintize email
    if email.instance_of? String 
      if validate email
        sanitized_email = email.strip.gsub(/\s+/, ' ')
        puts sanitized_email.downcase.gsub(' ', '')
        return  sanitized_email.downcase.gsub(' ', '')
      end
    end
    false
  end
  
end

# usage
#  EmailValidator.validate email
# EmailValidator.saintize email

# .strip.gsub(/\s+/, ' ')