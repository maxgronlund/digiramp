class PublisherValidator < ActiveModel::Validator
  def validate(record)
    
    if user = User.get_by_email( record.email )
      if user && (user.account.id != record.account_id)
        error_message = "The email is used by another account!"
        record.errors[:email] << error_message 
      end
    end
    
    if publisher = Publisher.find_by(email: record.email.downcase)
      error_message = "The email is used by another publisher!"
      record.errors[:email] << error_message 
    end
    
    #if record.i_am_my_own_publisher
    #  if user && (user.account.id != record.account_id)
    #    error_message = "This email is used by another account! Please disable I'm my owner publisher or use an email associated with this account"
    #    record.errors[:email] << error_message 
    #  end
    #else
    #  if user && (user.account.id == record.account_id)
    #    error_message = "This email is associated with this account! Please enable I'm my owner publisher or use an email not associated with this account " 
    #    record.errors[:email] << error_message 
    #  end
    #end
    #
    #if publisher = Publisher.find_by(email: record.email, user_id: record.user_id, account_id: record.account_id)
    #  unless publisher && (publisher.id == record.id)
    #    record.errors[:email] << 'You have already registered a publisher with that email' 
    #  end
    #end
    
  end
end