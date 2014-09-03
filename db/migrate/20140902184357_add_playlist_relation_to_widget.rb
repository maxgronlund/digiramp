class AddPlaylistRelationToWidget < ActiveRecord::Migration
  def change
    add_column :widgets, :playlist_id, :integer
    add_index  :widgets, :playlist_id
  end
end
