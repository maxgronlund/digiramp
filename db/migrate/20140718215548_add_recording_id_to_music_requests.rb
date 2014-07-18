class AddRecordingIdToMusicRequests < ActiveRecord::Migration
  def change
    add_column :music_requests, :recording_id, :integer
    #add_index :music_requests, :recording_id
  end
end
