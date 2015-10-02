class AddHasUnsignedDocumentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_unsigned_documents, :boolean
  end
end
