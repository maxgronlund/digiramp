class AddDateToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :date, :string
    
    Document.update_all(date: Date.today.to_s)
  end
end
