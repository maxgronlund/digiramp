class UpdateUuids < ActiveRecord::Migration
  def change
    
    remove_column :playlists, :uuid
    add_column :playlists, :uuid, :string, default: 'novel player'
    
    # force new uuids
    Recording.all.each do |recording|
      recording.save!
    end
    
    User.all.each do |user|
      user.save!
    end
    
    CommonWork.all.each do |common_work|
      common_work.save!
      
    end
    
    AccountUser.all.each do |account_user|
      account_user.save!
    end
    
    
  end
end
