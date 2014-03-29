class AddPlaylistKeyIdToCustomerEvents < ActiveRecord::Migration
  def change
    CustomerEvent.delete_all
    Playlist.delete_all
    PlaylistKey.delete_all
    add_column :customer_events, :playlist_key_id, :integer
    add_index  :customer_events, :playlist_key_id
  end
end
