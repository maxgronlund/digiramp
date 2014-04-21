class AddTransloaditToImportBatches < ActiveRecord::Migration
  def change
    add_column :import_batches, :transloadit, :text, default: ''
  end
end
