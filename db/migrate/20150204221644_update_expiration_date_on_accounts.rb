class UpdateExpirationDateOnAccounts < ActiveRecord::Migration
  def change
    Account.where(expiration_date: nil).each do |account|
      account.expiration_date = Date.current + 6.months
      account.save
    end  
  end

end
