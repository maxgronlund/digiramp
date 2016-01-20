class UpdateIdsOnStakes < ActiveRecord::Migration
  def change

    drop_table :stakes
    create_table "stakes", id: :uuid, force: :cascade do |t|
      t.integer  "account_id"
      t.integer  "asset_id"
      t.string   "asset_type"
      t.decimal  "split"                , default: 0.01
      t.integer  "flat_rate_in_cent"    , default: 10
      t.string   "currency",                  default: "usd"
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
      t.string   "email"
      t.integer  "ipiable_id"
      t.string   "ipiable_type"
      t.uuid   "channel_uuid"
    end

  end
end
