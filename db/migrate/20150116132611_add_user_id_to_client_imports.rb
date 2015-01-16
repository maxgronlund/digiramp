class AddUserIdToClientImports < ActiveRecord::Migration
  def change
    add_column :client_imports, :user_id, :integer
    add_index :client_imports, :user_id
    
    ClientImport.find_each do |client_import |
      client_import.user_id = client_import.account.user_id
      client_import.save!
    end
  end
end
