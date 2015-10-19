class AddUserRefToCommonWorkIpis < ActiveRecord::Migration
  def change
    
    
    create_table :notification_messages do |t|
      t.belongs_to :user, index: true, foreign_key: false
      t.references :asset, polymorphic: true, index: true
      t.text :error_message
      t.timestamps null: false
    end
    
    add_foreign_key :notification_messages, :users, on_delete: :cascade
    
    create_table :user_notifications do |t|
      t.belongs_to :user, index: true, foreign_key: false
      t.references :asset, polymorphic: true, index: true
      t.string :status
      t.text :message
    
      t.timestamps null: false
    end
    
    add_foreign_key "user_notifications", "users", on_delete: :cascade
    
    add_reference :common_work_ipis, :user, index: true, foreign_key: false
    
    CommonWorkIpi.find_each do |common_work_ip|
      common_work_ip.attach_to_user(common_work_ip.get_user)
    end
  end
end
