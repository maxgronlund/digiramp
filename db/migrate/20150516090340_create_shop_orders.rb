class CreateShopOrders < ActiveRecord::Migration
  def change
    #enable_extension 'uuid-ossp'
    
    create_table( :shop_orders, id: :uuid) do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :stripe_customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
