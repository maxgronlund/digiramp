class UserEmailValidator < ActiveModel::Validator
  def validate(record)
    if User.where(email: record.email).first
      record.errors[:email] << 'Email used by another account!'
    elsif
      UserEmail.where(email: record.email).first
      record.errors[:email] << 'Email used by another account!'
    end
    #unless record.name.starts_with? 'X'
    #  record.errors[:name] << 'Need a name starting with X please!'
    #end
  end
end