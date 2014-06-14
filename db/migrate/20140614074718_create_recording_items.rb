class CreateRecordingItems < ActiveRecord::Migration
  def change

    create_table :recording_items do |t|
      t.belongs_to :recording, index: true
      t.belongs_to :itemable, polymorphic: true
      t.timestamps
    end
    add_index :recording_items, [:itemable_id, :itemable_type]
    
    
  end
end
