class RenameColumnSubscriptionMessageOnMailCampigns < ActiveRecord::Migration
  def change
    rename_column :mail_campaigns, :subscription_message, :subscribtion_message
  end
end
