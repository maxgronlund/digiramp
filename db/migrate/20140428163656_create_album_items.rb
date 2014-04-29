class CreateAlbumItems < ActiveRecord::Migration
  def change
    create_table :album_items do |t|
      t.belongs_to :album, index: true
      t.belongs_to :albumable, polymorphic: true
      t.timestamps
    end
    add_index :album_items, [:albumable_id, :albumable_type]
  end
end


