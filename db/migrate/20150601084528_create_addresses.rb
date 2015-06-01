class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :address_type, default: 0 
      t.string :first_name
      t.string :last_name
      t.text :address_line_1
      t.text :address_line_2
      t.string :city
      t.string :state
      t.string :country
      t.references :addressable, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_column :shop_orders, :order_content, :text, default: {}

    
    remove_column :shop_orders, :address_line_1, :string
    remove_column :shop_orders, :address_line_2, :string
    remove_column :shop_orders, :zip, :string
    remove_column :shop_orders, :country, :string
    remove_column :shop_orders, :city, :string

  end
end
