class AddReceipientsToEmailGroups < ActiveRecord::Migration
  def change
    add_column :email_groups, :email_recipients, :text, default: ''
  end
end
