class UpdateDefaultWidgetKeyOnCatalogs < ActiveRecord::Migration
  def change
    remove_column :catalogs,  :default_widget_key
    add_column :catalogs,  :default_widget_key, :string
    add_index  :catalogs,  :default_widget_key
    
    Catalog.all.each do |catalog|
      catalog.default_widget_key = UUIDTools::UUID.timestamp_create().to_s
      catalog.save!
    end
  end
end
