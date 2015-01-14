class Admin::SetDefaultAvatarsController < ApplicationController
  before_filter :admin_only
  def index
    count = 0
    User.find_each do |user|
      unless File.exist?(Rails.root.join('public' +  user.image_url.to_s))
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
    redirect_to :back
  end
end


#File.exist?(Rails.root.join('public', user.image_url.to_s ))
#
#Rails.root.join('app', 'assets', 'images', "default-avatars/avatar_#{10.to_s}.jpg")
#File.exist?(Rails.root.join('app', 'assets', 'images', "default-avatars/avatar_#{10.to_s}.jpg"))
#
#Rails.root.join('public' +  user.image_url.to_s)
#
#File.exist?(Rails.root.join('public' +  user.image_url.to_s))