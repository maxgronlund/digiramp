class IpiEmailValidator < ActiveModel::Validator
  def validate(record)
    
    if user_id = record.user_id
    
      # if there is another user in the system with that email
      if user = User.where(email: record.email).first 
        unless user.id == user_id
          record.errors[:email] << 'Email already used!'
        end
      
      elsif email_user = UserEmail.where(email: record.email).first 
        if email_user.user_id && email_user.user_id != user_id
          record.errors[:email]  << 'Email already used!'
        end
      end
    end
   
  end
end

