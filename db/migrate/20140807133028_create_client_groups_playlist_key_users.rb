class CreateClientGroupsPlaylistKeyUsers < ActiveRecord::Migration
  def change
    create_table :client_groups_playlist_key_users do |t|
      t.belongs_to :client_group, index: true
      t.belongs_to :playlist_key_user, index: true
      t.timestamps
    end
  end
end
