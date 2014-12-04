class AddUnreadMessagesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unread_messages, :integer, default: 0
  end
end
