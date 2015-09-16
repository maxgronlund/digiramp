class CreateDistributionAgreements < ActiveRecord::Migration
  def change
    create_table :distribution_agreements do |t|
      t.belongs_to :label, index: true, foreign_key: false
      t.belongs_to :account, index: true, foreign_key: false
      t.integer :distributor_id
      t.integer :royalty, default: 10.0
      

      t.timestamps null: false
    end
    
    add_foreign_key "distribution_agreements", "labels", on_delete: :cascade
    add_foreign_key "distribution_agreements", "accounts", on_delete: :cascade
  end
end
