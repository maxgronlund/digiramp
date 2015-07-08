class SanitizeAccountUsers < ActiveRecord::Migration
  def change
    AccountUser.find_each do |account_user|
      unless account_user.user
        account_user.destroy
      end
    end
  end
end
