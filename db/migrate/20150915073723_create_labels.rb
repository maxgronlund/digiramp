class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :title
      t.text :body
      t.string :image
      t.boolean :activated
      t.belongs_to :user, index: true, foreign_key: false
      t.belongs_to :account, index: true, foreign_key: false

      t.timestamps null: false
    end
    
    add_foreign_key "labels", "users", on_delete: :cascade
    add_foreign_key "labels", "accounts",    on_delete: :cascade
    
    User.find_each do |user|
      Label.create(user_id: user.id, account_id: user.account.id, title: "#{user.get_full_name}'s Label", activated: !user.private_profile)
    end
    
    
  end
end
