class AddStripeChargeIdToGatewayPayments < ActiveRecord::Migration
  def change
    add_column :gateway_payments, :stripe_charge_id, :string
    add_column :gateway_payments, :order_id, :string
    add_column :gateway_payments, :order_item_id, :string
    add_column :gateway_payments, :no_payment_fee, :boolean, default: false
    rename_column :gateway_payments, :fee, :payment_fee
  end
end
