class UpdateNameOnUnreadMessages < ActiveRecord::Migration
  def change
    
    rename_column :users, :unread_messages, :messages_not_read
    
    User.find_each do | user |
      user.messages_not_read = user.received_massages.where(read: false, recipient_removed: false).count
      user.save!
    end
  end
end
