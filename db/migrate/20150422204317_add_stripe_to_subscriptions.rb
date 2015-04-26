class AddStripeToSubscriptions < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :plan, index: true, foreign_key: true
    add_column :subscriptions, :stripe_id, :string
  end
end
