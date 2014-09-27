class CreatePlaylistsRecordings < ActiveRecord::Migration
  def change
    create_table :playlists_recordings do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :recording, index: true

      t.timestamps
    end
  end
end
