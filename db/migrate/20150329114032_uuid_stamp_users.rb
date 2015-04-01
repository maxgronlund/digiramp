class UuidStampUsers < ActiveRecord::Migration
  def change
    User.where(uuid: ['', nil]).each do |user|
      user.uuid = UUIDTools::UUID.timestamp_create().to_s 
      user.save!
      
    end
  end
end
