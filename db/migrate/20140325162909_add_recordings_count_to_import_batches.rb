class AddRecordingsCountToImportBatches < ActiveRecord::Migration
  def change
    add_column :import_batches, :recordings_count, :integer, default: 0
  end
end
