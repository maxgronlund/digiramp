class AddAccountIdToActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.integer :account_id
    end
    add_index :activities, :account_id
  end
end
