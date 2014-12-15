class CreateMailListSubscribers < ActiveRecord::Migration
  def change
    create_table :mail_list_subscribers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :email_group, index: true

      t.timestamps
      
      remove_column :email_groups, :email_recipients
      remove_column :digiramp_emails, :recipients 
    end
  end
end
