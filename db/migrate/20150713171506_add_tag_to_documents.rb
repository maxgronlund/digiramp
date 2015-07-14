class AddTagToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :tag, :string, default: ''
    Document.update_all(tag: '')
  end
end
