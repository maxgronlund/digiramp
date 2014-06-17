class AddFileSizeToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :file_size, :integer, default: 0
  end
end
