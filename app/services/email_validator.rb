class EmailValidator
  
  def self.validate email
    /^\S+@\S+\.\S+$/.match(email).nil? ? false : true
  end
  
  def self.saintize email

    if validate email
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