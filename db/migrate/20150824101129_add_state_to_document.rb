class AddStateToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :status, :integer, default: 0
    add_column :documents, :expires, :boolean, default: false
    add_column :documents, :expiration_date, :date
    
    Document.update_all(status: 0, expires: false)
  end
end
