class DeleteCustomers < ActiveRecord::Migration
  def change
    drop_table :customers
    drop_table :customer_events
    
    
    create_table :customer_events do |t|
      t.string :event_type
      t.string :action_type
      t.string :title
      t.text :body
      t.boolean :folow_up
      t.date :follow_up_date
      t.belongs_to :account, index: true
      t.belongs_to :account_user, index: true
    
      t.timestamps
    end
    
    add_column :account_users, :phone, :string,  default: ''
    add_column :account_users, :name,  :string,  default: ''
    add_column :account_users, :note,  :text,    default: ''
    add_column :account_users, :email,  :string,    default: ''
    AccountUser.all.each do |account_user|
      begin
        account_user.email = account_user.user.email
        account_user.save!
      rescue
        account_user.destroy
      end
    end
    
  end
end
