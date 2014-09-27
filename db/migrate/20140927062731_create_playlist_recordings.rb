class CreatePlaylistRecordings < ActiveRecord::Migration
  def change
    create_table :playlist_recordings do |t|
      t.integer :playlist_id
      t.integer :recording_id
      t.timestamps
    end
    
    add_index :playlist_recordings, :playlist_id
    add_index :playlist_recordings, :recording_id
  end
end
