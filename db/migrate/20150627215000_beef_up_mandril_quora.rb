class BeefUpMandrilQuora < ActiveRecord::Migration
  def change
    User.find_each do |user|
      MandrillAccountService.update_account_quota_for_user user.id
    end
  end
end
