class AddMissingUuidsToUsers < ActiveRecord::Migration
  def change
    
    User.all.each do |user|
      if user.uuid.to_s == ''
        user.uuid = UUIDTools::UUID.timestamp_create().to_s 
        user.save!
      end
    end
  end
end
