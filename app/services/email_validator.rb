class EmailValidator
  
  def self.validate email
    return false if email.to_s == ''
    /^\S+@\S+\.\S+$/.match(email).nil? ? false : true
  end
  
end

# usage
#  EmailValidator.validate email