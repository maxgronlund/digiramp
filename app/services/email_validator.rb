class EmailValidator
  
  def self.validate email
    return /^\S+@\S+\.\S+$/.match(email).nil? ? false : true
  end
  
  def self.saintize email
   
    if email.instance_of? String 
      email = email.strip.gsub(/\s+/, ' ').downcase.gsub(' ', '')
      return email if validate email
    end
    false
  end
  
end

# usage
#  EmailValidator.validate "olivergale@gmail.com"
# EmailValidator.saintize email

# .strip.gsub(/\s+/, ' ')