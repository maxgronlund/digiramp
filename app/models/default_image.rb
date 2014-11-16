class DefaultImage < ActiveRecord::Base
  
  mount_uploader :user_avatar,        AvatarUploader
  mount_uploader :recording_artwork,  ArtworkUploader
  mount_uploader :company_logo,       LogoUploader
end
