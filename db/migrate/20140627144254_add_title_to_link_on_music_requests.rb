class AddTitleToLinkOnMusicRequests < ActiveRecord::Migration
  def change
    add_column :music_requests, :link_title, :string, default: 'Click Here'
  end
end
