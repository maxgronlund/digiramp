class EmailListValidator < ActiveModel::Validator
  
  def validate(record)
    record.email_list.split(',').each do |email|
      email.strip!
      unless match_email email
        
        record.errors[:email_list] = 'Please check for invalid emails'
      end
    end
  end
  
  def match_email email
    /\A([^@\s]+)@((?:(?!-)[-a-z0-9]+(?<!-)\.)+[a-z]{2,})\z/.match(email)
  end
  
end