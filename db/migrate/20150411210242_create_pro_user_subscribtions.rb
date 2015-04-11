class CreateProUserSubscribtions < ActiveRecord::Migration
  def change
    create_table :pro_user_subscribtions do |t|
      t.string :email
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end
