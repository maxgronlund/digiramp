class AddNrRecordingsToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :nr_recordings, :integer
    add_column :catalogs, :nr_common_works, :integer
    add_column :catalogs, :nr_assets, :integer
    add_column :catalogs, :nr_users, :integer
    add_column :catalogs, :uuid, :string
    
    Catalog.all.each do |catalog|
      catalog.update_assets_count
    end
  end
end
