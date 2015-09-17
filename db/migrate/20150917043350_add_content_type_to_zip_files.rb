class AddContentTypeToZipFiles < ActiveRecord::Migration
  def change
    add_column :zip_files, :content_type, :string
  end
end
