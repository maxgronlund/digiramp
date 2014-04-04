class UpdateBodyOnAccounts < ActiveRecord::Migration
  def change
    
    change_column :catalogs, :body,  :text
    
    
  end
end
