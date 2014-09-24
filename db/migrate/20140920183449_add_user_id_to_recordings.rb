class AddUserIdToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :user_id, :integer
    add_column :recordings, :published, :boolean, default: false
    add_index :recordings, :user_id
    
    Recording.all.each do |recording|
      
      if recording.account
        recording.user_id = recording.account.user_id
        recording.published = false
        recording.save!
        
      else
        puts recording.title
        recording.destroy
      end
    end
    
  end
end
