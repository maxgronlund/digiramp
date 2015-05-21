class RenameColumnAdditionlInfoOnShopItems < ActiveRecord::Migration
  def change
    rename_column :shop_products, :additionl_info, :additional_info
  end
end
