class PasswordValidator < ActiveModel::Validator
  def validate(record)
    if record.password.blank?
      record.errors[:password] << "Password can't be blank"
    end
    
    if record.password_confirmation.blank?
      record.errors[:password_confirmation] << "Password confirmation can't be blank"
    end
    

    #if record.password != record.password_confirmation
    #  record.errors[:password_confirmation] << "Password and Password confirmation don't match"
    #end
    
    #unless record.name.starts_with? 'X'
    #  record.errors[:name] << 'Need a name starting with X please!'
    #end
  end
end