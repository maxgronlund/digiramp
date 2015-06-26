class AddMandrillAccountIdToUsersWithout < ActiveRecord::Migration
  def change
    
    User.where(mandrill_account_id: nil).each do |user|
      begin
        CreateUserMandrillAccountJob.perform_later(user.id)
      rescue
        ap "no mandrill account created for #{user.user_name}"
      end
    end
    
    
  end
end
