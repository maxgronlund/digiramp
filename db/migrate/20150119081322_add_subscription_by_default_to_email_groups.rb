class AddSubscriptionByDefaultToEmailGroups < ActiveRecord::Migration
  def change
    add_column :email_groups, :subscription_by_default, :boolean, default: false
  end
end
