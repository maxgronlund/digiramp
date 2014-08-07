class CreatePlaylistKeyUsers < ActiveRecord::Migration
  def change
    create_table :playlist_key_users do |t|
      t.belongs_to :playlist_key, index: true
      t.belongs_to :account, index: true
      t.belongs_to :client, index: true
      t.string :user_uuid

      t.timestamps
    end
    
    add_column :client_groups_clients, :user_uuid, :string
  end
end
