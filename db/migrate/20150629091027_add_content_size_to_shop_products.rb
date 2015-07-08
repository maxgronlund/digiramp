class AddContentSizeToShopProducts < ActiveRecord::Migration
  def change
    add_column :shop_products, :content_type, :string
    add_column :shop_products, :file_size, :integer
    add_column :zip_files, :file_size, :integer
  end
end
