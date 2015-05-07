class AddCanceledToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :cancel_at_period_end, :boolean, default: false
    rename_column :subscriptions, :expiration_date, :current_period_end
    
  end
end
