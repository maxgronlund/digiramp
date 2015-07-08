class UpdateDigitalSignatures < ActiveRecord::Migration
  def change
    drop_table :digital_signatures
    
    create_table :digital_signatures do |t|
      t.string :uuid
      t.boolean :hidden, default: false
      t.belongs_to :user, index: true
      t.string :image

      t.timestamps null: false
    end
    
  end
end
