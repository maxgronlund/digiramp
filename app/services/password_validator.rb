class PasswordValidator
  
  def self.validate password, password_confirmation
    return false if password.to_s == ''
    return false if password != password_confirmation
    true
  end
  
  
  
end

# usage
#  PasswordValidator.validate password, password_confirmation
