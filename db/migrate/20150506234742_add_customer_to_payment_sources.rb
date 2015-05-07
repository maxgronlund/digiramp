class AddCustomerToPaymentSources < ActiveRecord::Migration
  def change
    add_column :payment_sources, :customer, :string
  end
end
