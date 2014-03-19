class CreateCustomerEvents < ActiveRecord::Migration
  def change
    create_table :customer_events do |t|
      t.string :event_type
      t.string :action_type
      t.string :title
      t.text :body
      t.boolean :folow_up
      t.date :follow_up_date
      t.belongs_to :account, index: true
      t.belongs_to :customer, index: true

      t.timestamps
    end
  end
end
