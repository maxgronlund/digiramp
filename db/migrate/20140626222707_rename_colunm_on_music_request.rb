class RenameColunmOnMusicRequest < ActiveRecord::Migration
  def up
    remove_column :music_requests, :music_opportunity_id
    add_column :music_requests, :oppertunity_id, :integer
    add_index :music_requests, :oppertunity_id
  end
  
  def down
    remove_column :music_requests, :opportunity_id
    add_column :music_requests, :music_opportunity_id, :integer
    #remove_index :music_requests, :opportunity_id
  end
end
