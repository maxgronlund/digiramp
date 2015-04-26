class AddFieldsToSale < ActiveRecord::Migration
  def change
    add_column :sales, :state, :string
    add_column :sales, :stripe_id, :string
    add_column :sales, :stripe_token, :string
    add_column :sales, :card_expiration, :date
    add_column :sales, :error, :text
    add_column :sales, :fee_amount, :integer
    add_column :sales, :amount, :integer
  end
end
