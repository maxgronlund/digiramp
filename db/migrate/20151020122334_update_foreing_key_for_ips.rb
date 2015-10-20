class UpdateForeingKeyForIps < ActiveRecord::Migration
  def change
    
    
    
    remove_foreign_key "ipis", "ipis"
    add_foreign_key "ipis", "users", on_delete: :cascade
    
  end
end
