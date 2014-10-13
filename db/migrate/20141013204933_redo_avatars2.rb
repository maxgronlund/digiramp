class RedoAvatars2 < ActiveRecord::Migration
  def change
    User.find_each do |user|
      if user.image
        begin
          user.image.recreate_versions!
          user.save!
        rescue
        end
      end
    end
  end
end
