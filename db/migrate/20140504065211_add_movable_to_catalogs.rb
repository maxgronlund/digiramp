class AddMovableToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :movable, :boolean, default: false
    add_column :catalogs, :include_all, :boolean, default: false
    
    Catalog.all.each do |catalog|
      catalog.move_code = UUIDTools::UUID.timestamp_create().to_s
      catalog.save!
    end
  end
end
