class UserValidator < ActiveModel::Validator
  def validate(record)
    if user_email = UserEmail.find_by(email: record.email)
     
      unless user_email.user_id == record.id
        record.errors[:email] << 'Email used by another account!'
      end
    end
    
    if publisher = Publisher.find_by(email: record.email)
      unless publisher.user_id == record.id
        record.errors[:email] << 'Email used by another account!'
      end
    end
    
    begin
      domain =  record.email.split('@').last.split('.').last(2).join(".")
      if BlacklistDomain.where(domain: domain).first
        record.errors[:email] << 'Sorry signup probitted! Please contact support is you think this is an error'
      end
    rescue
    end
    
  end
end