class UpdateExpirationDates < ActiveRecord::Migration
  def change
    Account.all.each do |account|
      if account.expiration_date.nil?
        account.expiration_date = Date.current()>>1 
        account.save!
      end
      if account.account_type.nil?
        account.account_type = 'free account'
        account.save!
      end
    end
  end
end
