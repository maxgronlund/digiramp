class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :amount_off
      t.integer :percent_off
      t.string :duration, default: 'once'
      t.integer :duration_in_months, default: 0
      t.string :stripe_id
      t.string :currency, default: 'usd'
      t.integer :max_redemptions, default: 1
      t.integer :times_redeemed, default: 0
      t.text :metadata
      t.date :redeem_by
      t.belongs_to :plan, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
