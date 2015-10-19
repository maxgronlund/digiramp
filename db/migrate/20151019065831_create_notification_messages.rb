class CreateNotificationMessages < ActiveRecord::Migration
  def change
    #create_table :notification_messages do |t|
    #  t.belongs_to :user, index: true, foreign_key: false
    #  t.references :asset, polymorphic: true, index: false
    #  t.text :error_message
    #
    #  t.timestamps null: false
    #end
    #
    #add_foreign_key :item_likes, :notification_messages, on_delete: :cascade
    
    
    create_table :notification_messages do |t|
      t.belongs_to :user, index: true, foreign_key: false
      t.references :asset, polymorphic: true, index: true
      t.text :error_message
      t.timestamps null: false
    end
    
    add_foreign_key :notification_messages, :users, on_delete: :cascade
    
    remove_column :user_notifications, :error_message, :text
  end
end
