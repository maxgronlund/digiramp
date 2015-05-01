class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :stripe_id
      t.string :stripe_object
      t.boolean :livemode
      t.integer :amount_due
      t.boolean :attempted
      t.boolean :closed
      t.string :currency
      t.string :stripe_customer_id
      t.boolean :discountable
      t.date :date
      t.boolean :forgiven
      t.text :lines
      t.boolean :paid
      t.date :period_start
      t.date :period_end
      t.integer :starting_balance
      t.integer :subtotal
      t.integer :total
      t.integer :application_fee
      t.string :charge
      t.string :description
      t.text :discount
      t.integer :ending_balance
      t.string :receipt_number
      t.string :statement_descriptor
      t.string :subscription_id
      t.text :metadata
      t.integer :tax
      t.decimal :tax_percent
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
