class CreateStripeCustomers < ActiveRecord::Migration
  def change
    create_table :stripe_customers do |t|
      t.string :stripe_object
      t.date :created
      t.string :stripe_id
      t.boolean :livemode
      t.string :description
      t.string :email
      t.boolean :delinquent
      t.text :metadata
      t.text :subscriptions
      t.text :discount
      t.integer :account_balance
      t.string :currency
      t.text :sources
      t.string :default_source

      t.timestamps null: false
    end
  end
end
