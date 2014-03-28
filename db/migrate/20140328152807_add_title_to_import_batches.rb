class AddTitleToImportBatches < ActiveRecord::Migration
  def change
    add_column :import_batches, :title, :string, default: 'import batch'
    add_column :import_batches, :csv_file, :string
  end
end
