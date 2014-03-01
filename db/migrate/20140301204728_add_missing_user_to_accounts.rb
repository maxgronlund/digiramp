class AddMissingUserToAccounts < ActiveRecord::Migration
  def change
    Account.all.each do |account|
      account.user_id = User.first.id if account.user.nil?
      unless User.exists?(account.user_id)
        account.user_id = User.first.id
      end
      account.save!
    end
  end
end
