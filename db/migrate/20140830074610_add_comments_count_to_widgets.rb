class AddCommentsCountToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :comments_count, :integer, default: 0
    add_column :widgets, :playback_count, :integer, default: 0
    add_column :widgets, :playlists_count, :integer, default: 0
  end
end
