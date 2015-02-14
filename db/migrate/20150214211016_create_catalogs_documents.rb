class CreateCatalogsDocuments < ActiveRecord::Migration
  def change
    create_table :catalogs_documents do |t|
      t.belongs_to :catalog, index: true
      t.belongs_to :document, index: true

      t.timestamps
    end
    
    Catalog.find_each do |catalog|
      catalog.documents.each do |document|
        CatalogsDocuments.create( catalog_id: catalog.id, document_id: document.id)
      end
    end
  end
end
