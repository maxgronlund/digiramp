class UpdateDefaultsOnMessages < ActiveRecord::Migration
  def change
    
    remove_column :messages, :sender_removed 
    remove_column :messages, :recipient_removed
    
    add_column :messages, :sender_removed,    :boolean, default: false
    add_column :messages, :recipient_removed, :boolean, default: false
    
    Message.find_each do |message|
      message.sender_removed       = false
      message.recipient_removed       = false
    end
  end
end
