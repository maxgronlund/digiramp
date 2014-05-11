class AddImageFileIdToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :image_file_id, :integer
    
    add_index :recordings, :image_file_id
  end
end
