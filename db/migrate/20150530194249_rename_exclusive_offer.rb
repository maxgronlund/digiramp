class RenameExclusiveOffer < ActiveRecord::Migration
  def change
    rename_column :shop_products, :exclusive_offer, :exclusive_offered_to_email
  end
end
