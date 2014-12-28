class RecreateUserAvatars < ActiveRecord::Migration
  def change
    count = 0
    User.find_each do |user|
      begin
        user.image.recreate_versions!
      rescue
        count = 0 if count > 12
        if count < 10
          id = '0' + count.to_s 
        else
          id = count.to_s 
        end
        user.image = File.open(Rails.root.join('app', 'assets', 'images', "default-avatars/avatar_#{id}.jpg"))
        user.image.recreate_versions!
        user.save!
        count += 1
      end
    end

  end
end
