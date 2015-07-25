class UserValidator < ActiveModel::Validator
  def validate(record)
    if UserEmail.where(email: record.email).first
      record.errors[:email] << 'Email has been added to another account!'
    end
    #unless record.name.starts_with? 'X'
    #  record.errors[:name] << 'Need a name starting with X please!'
    #end
  end
end