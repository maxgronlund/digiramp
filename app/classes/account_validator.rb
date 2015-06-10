class AccountValidator < ActiveModel::Validator
  
  def validate(record)
    if record.stripe_flat_transfer_fee < 0
      record.errors[:stripe_flat_transfer_fee] = 'Flat fee can be less than 0'
    end

    if record.stripe_percent_transfer_fee < 0.0
      record.errors[:stripe_percent_transfer_fee] = 'Percentage fee can be less than 0.0'
    elsif record.stripe_percent_transfer_fee > 1.0
      record.errors[:stripe_percent_transfer_fee] = 'Percentage fee can be greater than 1.0'
    end
    
  end
  
 
  
end