class CreatePlaybacks < ActiveRecord::Migration
  def change
    create_table :playbacks do |t|
      t.belongs_to :user, index: true
      t.belongs_to :recording, index: true
      t.belongs_to :account, index: true

      t.timestamps
    end
    add_column :recordings, :playbacks_count, :integer, default: 0
    
    create_table :likes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :recording, index: true
      t.belongs_to :account, index: true

      t.timestamps
    end
    add_column :recordings, :likes_count, :integer, default: 0
    
    Recording.all.each do |recording|
      recording.playbacks_count = 0
      recording.likes_count = 0
      recording.save!
    end
  end
end
