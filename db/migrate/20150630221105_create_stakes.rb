class CreateStakes < ActiveRecord::Migration
  def change
    create_table :stakes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :account, index: true, foreign_key: true
      t.references :asset, polymorphic: true, index: true
      t.decimal :split_in_percent
      t.integer :flat_rate_in_cent
      t.string :currency, default: 'usd'

      t.timestamps null: false
    end
  end
end
