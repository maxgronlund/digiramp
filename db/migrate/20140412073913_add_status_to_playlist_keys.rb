class AddStatusToPlaylistKeys < ActiveRecord::Migration
  def change
    add_column :playlist_keys, :status, :string, default: 'new'
  end
end
