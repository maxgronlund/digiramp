class AddStripePlanToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_plan, :text
    add_column :subscriptions, :stripe_object, :string
    add_column :subscriptions, :start, :date
    add_column :subscriptions, :stripe_customer, :string
    add_column :subscriptions, :current_period_start, :date
    #add_column :subscriptions, :current_period_end, :date
    add_column :subscriptions, :ended_at, :date
    add_column :subscriptions, :trial_start, :date
    add_column :subscriptions, :trial_end, :date
    add_column :subscriptions, :canceled_at, :date
    add_column :subscriptions, :quantity, :integer
    add_column :subscriptions, :application_fee_percent, :decimal
    add_column :subscriptions, :discount, :text
    add_column :subscriptions, :tax_percent, :decimal
    add_column :subscriptions, :metadata, :text
    
    remove_column :subscriptions, :months
    remove_column :subscriptions, :account_type
    remove_column :subscriptions, :cardholders_name
    remove_column :subscriptions, :card_expiration_date
    remove_column :subscriptions, :expired

  end
end
