# encoding: utf-8

class PlaylistUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  
  def default_url
    "/assets/fallback/" + [version_name, "playlist.jpg"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :image_120x120 do
     process  resize_to_fill: [120, 120, gravity = 'Center']
  end
  
  version :image_220x220 do
     process  resize_to_fill: [220, 220, gravity = 'Center']
  end
  
  version :image_270x270 do
     process  resize_to_fill: [270, 270, gravity = 'Center']
  end
  
  version :image_470x250 do
     process  resize_to_fill: [470, 250, gravity = 'Center']
  end
  
  

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end

#:avatar_32x32     => [32,32],
#:avatar_64x64     => [64,64],
#:avatar_120x120   => [120,120],
#:avatar_170x170   => [170, 170]
#:avatar_270x270   => [270, 270]
#:avatar_370x370   => [370, 370]