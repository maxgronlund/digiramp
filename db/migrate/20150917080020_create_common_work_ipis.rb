class CreateCommonWorkIpis < ActiveRecord::Migration
  def change
    create_table :common_work_ipis do |t|
      t.belongs_to :common_work, index: true, foreign_key: false
      t.belongs_to :ipi, index: true, foreign_key: false

      t.timestamps null: false
    end
    
    add_foreign_key "common_work_ipis", "common_works", on_delete: :cascade
    add_foreign_key "common_work_ipis", "ipis", on_delete: :cascade
  end
end
