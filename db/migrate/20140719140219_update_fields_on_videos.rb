class UpdateFieldsOnVideos < ActiveRecord::Migration
  def change
    
    add_column :videos, :file, :string, default: ''
    add_column :videos, :transloadit, :text
    add_column :videos, :account_id, :integer
    add_index :videos, :account_id
  end
end
