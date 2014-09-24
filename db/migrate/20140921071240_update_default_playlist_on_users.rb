class UpdateDefaultPlaylistOnUsers < ActiveRecord::Migration
  def change
    
    User.all.each do |user|
      user.update_widget
    end
  end
end
