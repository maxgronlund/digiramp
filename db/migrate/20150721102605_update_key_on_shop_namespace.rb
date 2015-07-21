class UpdateKeyOnShopNamespace < ActiveRecord::Migration
  def change

    drop_table :shop_stripe_transfers
    drop_table :shop_orders
    drop_table :shop_products
    drop_table :stripe_webhooks
    drop_table :shop_physical_products
    
    create_table "shop_products", id: :uuid, force: :cascade do |t|
      t.string   "title"
      t.text     "body"
      t.text     "additional_info"
      t.string   "image"
      t.integer  "price"
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :account, index: true, foreign_key: true
      t.string   "download_link"
      t.boolean  "for_sale"
      t.datetime "created_at",                                              null: false
      t.datetime "updated_at",                                              null: false
      t.string   "category"
      t.integer  "units_on_stock",             default: 0
      t.string   "exclusive_offered_to_email"
      t.string   "uuid"
      t.boolean  "show_in_shop",               default: false
      t.references :productable, polymorphic: true, index: true
      t.integer  "views",                      default: 0
      t.string   "delivery_time",              default: "Two to four days"
      t.integer  "shipping_cost"
      t.text     "disclaimer",                 default: ""
      t.text     "tems_of_usage",              default: ""
      t.integer  "vat",                        default: 0
      t.boolean  "vat_included",               default: true
      t.string   "sub_category",               default: ""
      t.string   "zip_file"
      t.string   "content_type"
      t.integer  "file_size"
      t.belongs_to :document, index: true, foreign_key: true
    end
    
    
    create_table "shop_orders", id: :uuid, force: :cascade do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.datetime "created_at",                                null: false
      t.datetime "updated_at",                                null: false
      t.string   "state"
      #t.string   "uuid"
      t.string   "stripe_token"
      t.integer  "coupon_id"
      t.string   "email"
      t.string   "error"
      t.string   "charge_id"
      t.text     "invoice_object"
      t.text     "order_lines"
      t.text     "order_content",        default: "--- {}\n"
      t.string   "billing_address"
      t.text     "card_address_name"
      t.text     "card_address_line_1"
      t.text     "card_address_line_2"
      t.string   "card_address_city"
      t.string   "card_address_state"
      t.string   "card_address_zip"
      t.string   "card_address_country"
      t.boolean  "checked_out",          default: false
    end
    
    drop_table :shop_order_items
    create_table "shop_order_items", id: :uuid, force: :cascade do |t|
      t.integer  "quantity",         default: 1
      t.datetime "created_at",                       null: false
      t.datetime "updated_at",                       null: false
      t.belongs_to :shop_order, index: true, foreign_key: true, type: :uuid
      t.belongs_to :shop_product, index: true, foreign_key: true, type: :uuid
      t.boolean  "require_shipping", default: false
      t.boolean  "sold",             default: false
    end

    
    create_table "shop_stripe_transfers", id: :uuid, force: :cascade do |t|
      t.belongs_to :shop_order, index: true, foreign_key: true, type: :uuid
      t.belongs_to :shop_order_item, index: true, foreign_key: true, type: :uuid
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :account, index: true, foreign_key: true
      t.belongs_to :stake, index: true, foreign_key: true, type: :uuid
      t.decimal  "split"
      t.date     "due_date"
      t.integer  "amount"
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
      t.string   "destination"
      t.string   "source_transaction"
      t.string   "currency",           default: "usd"
      t.string   "state",              default: "pending"
      t.string   "stripe_errors"
      t.string   "description"
    end

    
  end
end
