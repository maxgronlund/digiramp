# encoding: utf-8

class ThumbUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "thumb.png"].compact.join('_'))
    #"/assets/fallback/" + [version_name, "thumb.png"].compact.join('_')
  end
  

  
  # Create different versions of your uploaded files:
  version :thumb do
    #process :resize_to_fit => [200, 113]
    resize_and_pad(200, 113,:transparent,'Center')
    process :convert => 'png'
  end
  
  version :preview do
    process :resize_to_fit => [1012, 632]
    #resize_and_pad(1012, 632,:transparent,'Center')
    #process :convert => 'png'
  end
  
  version :cover_thumb do
    resize_and_pad(128, 128,:transparent,'Center')
    process :convert => 'png'
  end
  
  def extension_white_list
    %w(jpg jpeg gif png bmp tif tiff)
  end
  
    
    
end