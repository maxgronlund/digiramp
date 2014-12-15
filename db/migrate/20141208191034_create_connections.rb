class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.belongs_to :user, index: true
      t.integer :connection_id
      t.boolean :approved, default: false
      t.boolean :dismissed, default: false
      t.text :message, default: ''

      t.timestamps
    end
  end
end
