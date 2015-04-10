class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :registration
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.date :card_expires_on

      t.timestamps
    end
    
    create_table :card_transactions do |t|
      t.references :card, index: true
      t.string :action
      t.integer :amount
      t.boolean :success
      t.string :authorization
      t.string :message
      t.text :params

      t.timestamps
    end
    
    
  end
end
