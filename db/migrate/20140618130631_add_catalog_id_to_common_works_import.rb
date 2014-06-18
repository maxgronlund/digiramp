class AddCatalogIdToCommonWorksImport < ActiveRecord::Migration
  def change
    
    
    add_column :common_works_imports, :ascap_work_id, :string
    add_column :common_works_imports, :catalog_id, :string
    add_index :common_works_imports, :catalog_id
  end
end
