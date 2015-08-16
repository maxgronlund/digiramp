class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.belongs_to :account, foreign_key: false
      t.belongs_to :user, foreign_key: false
      t.string :legal_name
      t.string :email
      t.string :phone_number
      t.string :ipi_code
      t.string :cae_code
      t.belongs_to :pro_affiliation, foreign_key: true
      t.integer :status, default: 0
      t.boolean :i_am_my_own_publisher
      t.boolean :show_on_public_page, default: false
      t.text :description
      t.timestamps null: false
    end
    add_foreign_key :publishers, :accounts, on_delete: :cascade
  end

  
end
