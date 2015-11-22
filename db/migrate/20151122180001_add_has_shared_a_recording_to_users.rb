class AddHasSharedARecordingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_shared_a_recording, :boolean, default: false
    
    User.find_each do |user|
      user.set_has_shared_a_recording
    end
  end
end
