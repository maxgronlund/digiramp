class AddImageToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :image, :string, default: ''
    
    Catalog.find_each do |catalog|
      catalog.check_default_image
    end
  end
end
