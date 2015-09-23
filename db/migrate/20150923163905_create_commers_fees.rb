class CreateCommersFees < ActiveRecord::Migration
  def change
    create_table :commers_fees do |t|
      t.decimal :digiramp_percentage_fee, default: 1.4
      t.integer :digiramp_flat_fee, default: 1
      t.decimal :stripe_percentage_fee, default: 2.9
      t.integer :stripe_flat_fee, default: 30

      t.timestamps null: false
    end
  end
end
