class AddDocumentIdToShopProducts < ActiveRecord::Migration
  def change
    add_reference :shop_products, :document, index: true, foreign_key: true
    Shop::Product.update_all(document_id: nil)
  end
end
