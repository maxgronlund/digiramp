class CreateCatalogsRecordings < ActiveRecord::Migration
  def change
    create_table :catalogs_recordings do |t|
      t.belongs_to :catalog, index: true
      t.belongs_to :recording, index: true

      t.timestamps
    end
    
    Catalog.find_each do |catalog|
      catalog.recordings.each do |recording|
        CatalogsRecordings.create(catalog_id: catalog.id, recording_id: recording.id)
      end
    end
    
  end
end
