class CreateArtworksCatalogs < ActiveRecord::Migration
  def change
    create_table :artworks_catalogs do |t|
      t.belongs_to :artwork, index: true
      t.belongs_to :catalog, index: true

      t.timestamps
    end
    
    Catalog.find_each do |catalog|
      catalog.artworks.each do |artwork|
        ArtworksCatalogs.create( artwork_id: artwork.id, catalog_id: catalog.id)
      end
    end
    
    
  end
end
