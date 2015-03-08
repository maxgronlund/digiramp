class CreateCatalogsCommonWorks < ActiveRecord::Migration
  def change
    create_table :catalogs_common_works do |t|
      t.belongs_to :catalog, index: true
      t.belongs_to :common_work, index: true

      t.timestamps
    end
    
    Catalog.find_each do |catalog|
      catalog.common_works.each do |common_work|
        CatalogsCommonWorks.create(catalog_id: catalog.id, common_work_id: common_work.id)
      end
    end
  end
end
