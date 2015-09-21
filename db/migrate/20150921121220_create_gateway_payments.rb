class CreateGatewayPayments < ActiveRecord::Migration
  def change
    create_table :gateway_payments do |t|
      t.uuid :stake_id
      t.decimal :fee
      t.string :gateway
      t.integer :amount

      t.timestamps null: false
    end
    
    add_index :gateway_payments, :stake_id
    add_foreign_key "gateway_payments", "stakes", on_delete: :cascade
    
  end
end
