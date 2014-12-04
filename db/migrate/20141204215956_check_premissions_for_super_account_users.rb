class CheckPremissionsForSuperAccountUsers < ActiveRecord::Migration
  def change
    
    AccountUser.where(role: 'Super User').each do |account_user|
      unless account_user.read_opportunity
        account_user.create_opportunity = true
        account_user.read_opportunity   = true
        account_user.update_opportunity = true
        account_user.delete_opportunity = true
        account_user.save!
      end
    end
  end
end
