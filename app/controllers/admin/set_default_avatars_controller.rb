class Admin::SetDefaultAvatarsController < ApplicationController
  before_action :admin_only
  def index
    User.find_each do |user|
      user.set_default_avatar
    end
    redirect_to admin_engine_room_index_path
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