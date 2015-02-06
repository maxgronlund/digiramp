class CreateCmsPlaylistLinks < ActiveRecord::Migration
  def change
    create_table :cms_playlist_links do |t|
      t.integer :position
      t.belongs_to :playlist, index: true

      t.timestamps
    end
  end
end
