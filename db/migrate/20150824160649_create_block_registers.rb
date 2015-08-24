class CreateBlockRegisters < ActiveRecord::Migration
  def change
    create_table :block_registers do |t|
      t.text :secret

      t.timestamps null: false
    end
  end
end
