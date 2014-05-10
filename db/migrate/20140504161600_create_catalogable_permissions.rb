class CreateCatalogablePermissions < ActiveRecord::Migration
  def change
    add_column :recordings, :artwork, :string, default: '' 
    add_column :recordings, :original_file, :string, default: '' 
  end
end
