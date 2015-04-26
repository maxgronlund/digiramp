class AddStateToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :state, :string
    add_column :subscriptions, :guid, :string
    add_column :subscriptions, :error, :string
    add_column :subscriptions, :stripe_token, :string
  end
end
