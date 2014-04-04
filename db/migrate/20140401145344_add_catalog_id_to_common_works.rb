class AddCatalogIdToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :catalog_id, :integer
    add_index  :common_works, :catalog_id
  end
end
