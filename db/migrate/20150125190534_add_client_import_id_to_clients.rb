class AddClientImportIdToClients < ActiveRecord::Migration
  def change
    add_column :clients, :client_import_id, :integer
    add_index :clients, :client_import_id
    
    add_column :client_imports, :source, :string, default: ''
  end
end
