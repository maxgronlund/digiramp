class AddExpiresToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :expiration_date, :date
    add_column :subscriptions, :card_expiration_date, :date
    add_column :subscriptions, :expired, :boolean, default: false

  end
end
