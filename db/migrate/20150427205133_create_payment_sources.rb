class CreatePaymentSources < ActiveRecord::Migration
  def change
    create_table :payment_sources do |t|
      t.belongs_to :subscription, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.string  :stripe_id
      t.text  :stripe_data
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
