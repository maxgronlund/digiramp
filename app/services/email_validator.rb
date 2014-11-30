class EmailValidator
  
  def self.validate email
    if email.instance_of?( String)
       return /^\S+@\S+\.\S+$/.match(email).nil? ? false : true
    end
    false
  end
  
  def self.saintize email
    if validate email  && email.instance_of?( String)
      sanitized_email = email.strip.gsub(/\s+/, ' ')
      return  sanitized_email.downcase.gsub(' ', '')
    end
    false
  end
  
end

# usage
#  EmailValidator.validate email
# EmailValidator.saintize email

# .strip.gsub(/\s+/, ' ')