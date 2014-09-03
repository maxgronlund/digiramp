class UpdateUuids < ActiveRecord::Migration
  def change
    
    #remove_column :playlists, :uuid
    add_column :playlists, :uuid, :string, default: UUIDTools::UUID.timestamp_create().to_s
    
    # force new uuids
    Recording.all.each do |recording|
      recording.save!(:validate => false)
    end
    
    User.all.each do |user|
      user.save!(:validate => false)
    end
    
    CommonWork.all.each do |common_work|
      common_work.save!(:validate => false)
      
    end
    
    AccountUser.all.each do |account_user|
      account_user.save!(:validate => false)
    end
    
    
  end
end
