class UpdateUserAvatars < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      begin
        if File.exist?(Rails.root.join('public' +  user.image_url.to_s))
          user.image.recreate_versions!(:avatar_220x220)
          user.save!
        else
          user.set_default_avatar
        end
      rescue
        puts '========================================================================================================================================='
        puts user.id
        puts '========================================================================================================================================='
      end
     
    end
  end
end
