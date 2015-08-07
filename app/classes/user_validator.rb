class UserValidator < ActiveModel::Validator
  def validate(record)
    if UserEmail.where(email: record.email).first
      record.errors[:email] << 'Email has been added to another account!'
    end
    
    begin
      domain =  record.email.split('@').last.split('.').last(2).join(".")
      if BlacklistDomain.where(domain: domain).first
        record.errors[:email] << 'Email domain is blacklisted! Please contact support is you think this is an error'
      end
    rescue
    end
    #unless record.name.starts_with? 'X'
    #  record.errors[:name] << 'Need a name starting with X please!'
    #end
  end
end