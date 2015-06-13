class CreateAdminMandrillAccounts < ActiveRecord::Migration
  def change
    create_table :mandrill_accounts do |t|
      t.belongs_to :account, index: true, foreign_key: true
      t.string :notes
      t.integer :custom_quota

      t.timestamps null: false
    end
  end
end
