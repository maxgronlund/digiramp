class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email
      t.belongs_to :user, index: true
      t.integer :send_to_user_id
      t.belongs_to :account, index: true
      t.string :email_type
      t.string :content_type
      t.text :content

      t.timestamps
    end
    
    add_index :emails, :send_to_user_id
  end
end
