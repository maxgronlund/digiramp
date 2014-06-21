class UpdateAssetsCounts < ActiveRecord::Migration
  def change
    
    Catalog.all.each do |catalog|
      catalog.update_assets_count
    end
  end
end
