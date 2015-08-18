class AddUuidToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :uuid, :uuid
    
    Document.find_each do |document|
      document.uuid = UUIDTools::UUID.timestamp_create().to_s
      document.save(validate: false)
    end
  end
end
