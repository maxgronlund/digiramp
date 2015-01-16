class ZipFile < ActiveRecord::Base
  
  mount_uploader :zip_file, ZipUploader
end
