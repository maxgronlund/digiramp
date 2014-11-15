class DefaultImage < ActiveRecord::Base
  
  mount_uploader :user_avatar, AvatarUploader
  mount_uploader :recording_artwork, AvatarUploader
  mount_uploader :company_logo, AvatarUploader
end
