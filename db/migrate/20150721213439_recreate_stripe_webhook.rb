class RecreateStripeWebhook < ActiveRecord::Migration
  def change
    create_table "stripe_webhooks", force: :cascade do |t|
      t.string   "stripe_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
