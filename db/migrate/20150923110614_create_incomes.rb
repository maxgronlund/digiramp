class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.belongs_to :user, index: true, foreign_key: false
      t.belongs_to :account, index: true, foreign_key: false
      t.uuid    :stake_id
      t.integer :amount, default: 0
      t.integer :application_fee, default: 0
      t.integer :payment_fee, default: 0
      t.string  :source_transaction

      t.timestamps null: false
    end
    add_index :incomes, :stake_id
    add_foreign_key "incomes", "stakes", on_delete: :cascade
    
    Stake.find_each do |stake|
      stake.stripe_transfers.each do |stripe_transfers|
        Income.create(
          stake_id:             stake.id,
          user_id:              stake.user_id,
          account_id:           stake.account_id,
          amount:               stripe_transfers.amount,
          application_fee:      stripe_transfers.application_fee,
          payment_fee:          stripe_transfers.payment_fee,
          source_transaction:   stripe_transfers.source_transaction,
        )
      end
      
    end
  end
end
