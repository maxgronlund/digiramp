class CreateFollowerEvents < ActiveRecord::Migration
  def change
    create_table :follower_events do |t|
      t.belongs_to :user, index: true
      t.text :body
      t.string :url
      
      t.belongs_to :postable, polymorphic: true

      t.timestamps
    end
    
    add_index :follower_events, [:postable_id, :postable_type]
    
  end
end
