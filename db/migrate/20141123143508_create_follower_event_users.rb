class CreateFollowerEventUsers < ActiveRecord::Migration
  def change
    create_table :follower_event_users do |t|
      t.belongs_to :follower_event, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
