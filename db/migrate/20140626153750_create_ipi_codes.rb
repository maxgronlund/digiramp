class CreateIpiCodes < ActiveRecord::Migration
  def change
    create_table :ipi_codes do |t|
      t.belongs_to :account, index: true
      t.belongs_to :ipiable, polymorphic: true
      t.string :ipi_code
      t.string :title
      t.string :pro
      t.string :role
      t.timestamps
    end
    add_index :ipi_codes, [:ipiable_id, :ipiable_type]
  end
end



