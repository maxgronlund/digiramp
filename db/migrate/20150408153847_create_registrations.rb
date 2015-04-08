class CreateRegistrations < ActiveRecord::Migration
  
  def change
    create_table :registrations do |t|
      t.references :order, index: true
      t.string :full_name
      t.string :company
      t.string :email
      t.string :telephone

      t.timestamps
    end
    
    add_column :registrations, :notification_params, :text
    add_column :registrations, :status, :string
    add_column :registrations, :transaction_id, :string
    add_column :registrations, :purchased_at, :datetime
    
  end
end
