class CreateShopProducts < ActiveRecord::Migration
  def change
    create_table :shop_products do |t|
      t.string :title
      t.text :body
      t.text :additionl_info
      t.string :image
      t.integer :price
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :account, index: true, foreign_key: true
      t.string :download_link
      t.boolean :for_sale

      t.timestamps null: false
    end
  end
end
