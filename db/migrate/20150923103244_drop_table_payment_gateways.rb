class DropTablePaymentGateways < ActiveRecord::Migration
  def change
    drop_table :gateway_payments
  end
end
