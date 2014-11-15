class EmailValidator
  
  def self.validate email
    /^\S+@\S+\.\S+$/.match(email).nil? ? false : true
  end
  
end

# usage
#  EmailValidator.validate email