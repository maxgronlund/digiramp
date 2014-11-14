class AddArtistToUsers < ActiveRecord::Migration
  def change
    add_column :users, :artist, :boolean, default: false
    remove_column :users, :fan
  end
end
