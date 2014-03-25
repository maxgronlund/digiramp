class CreateImportBatches < ActiveRecord::Migration
  def change
    create_table :import_batches do |t|
      t.belongs_to :account, index: true

      t.timestamps
    end
    
    add_column :recordings, :import_batch_id, :integer
    
    add_index :recordings, :import_batch_id
  end
end
