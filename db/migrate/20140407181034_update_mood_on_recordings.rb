class UpdateMoodOnRecordings < ActiveRecord::Migration
  def change
    change_column :recordings, :mood,  :text, default: ''
    add_column :moods, :category,  :string, default: ''
    
  end
end
