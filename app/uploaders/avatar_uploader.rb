# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  #include Sprockets::Helpers::RailsHelper
  #include Sprockets::Helpers::IsolatedHelper
  
  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    #"/assets/fallback/" + [version_name, "default.jpg"].compact.join('_')
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.jpg"].compact.join('_'))
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  process :quality => 85
  process :convert => 'jpg'
  process :resize_to_limit => [1024, 1024]

  # Create different versions of your uploaded files:  
  #cattr_accessor :version_dimensions
  #self.version_dimensions = {
  #  :avatar_32x32     => [32,32],
  #  :avatar_64x64     => [64,64],
  #  :avatar_120x120   => [120,120],
  #  :avatar_170x170   => [170, 170],
  #  :avatar_270x270   => [270, 270],
  #  :avatar_370x370   => [370, 370]
  #}
  
  version :avatar_32x32    do process :resize_to_fill => [32,32   , 'Center']      end
  version :avatar_48x48    do process :resize_to_fill => [48,48   , 'Center']      end
  version :avatar_64x64    do process :resize_to_fill => [64,64   , 'Center']      end
  version :avatar_92x92    do process :resize_to_fill => [92,92   , 'Center']      end
  version :avatar_120x120  do process :resize_to_fill => [120,120 , 'Center']      end
  version :avatar_145x145  do process :resize_to_fill => [145,145 , 'Center']      end
  version :avatar_170x170  do process :resize_to_fill => [170, 170, 'Center']      end
  version :avatar_184x184  do process :resize_to_fill => [184, 184, 'Center']      end
  version :avatar_220x220  do process :resize_to_fill => [220, 220, 'Center']      end
  version :avatar_270x270  do process :resize_to_fill => [270, 270, 'Center']      end










#  RESIZE_GRAVITY = 'NorthWest'
#
#  # define versions from dimensions above
#  self.version_dimensions.keys.each do |a_version|
#    eval <<-EOT
#      version :#{a_version} do
#        process :resize_to_fill => self.version_dimensions[:#{a_version}]
#      end
#EOT
#  end

  #def manualcrop
  #  return unless model.cropping?
  #  return if model.crop_params[version_name.to_sym].blank?
  #
  #  model.get_crop_version!(version_name)
  #
  #  manipulate_crop! do |img|
  #    img.crop("#{model.crop_w.to_i}x#{model.crop_h.to_i}+#{model.crop_x.to_i}+#{model.crop_y.to_i}")
  #  end
  #end

  #def manipulate_crop!
  #  crop_image = ::MiniMagick::Image.open(current_path)
  #  yield(crop_image)
  #  crop_image.write(current_path)
  #rescue => e
  #  raise CarrierWave::ProcessingError.new("Failed to manipulate with MiniMagick, maybe it is not an image? Original Error: #{e}")
  #end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png bmp tif tiff)
  end

  # Override the filename of the uploaded files:
  #Avoid using model.id or version_name here, see uploader/store.rb for details.


#  def filename
#    if original_filename
#      if model && model.read_attribute(mounted_as).present?
#        model.read_attribute(mounted_as)
#      else
#        @name ||= "#{mounted_as}-#{uuid}.#{file.extension}"
#      end
#    end
#  end
#
#protected  
#  def uuid
#    UUID.state_file = false
#    uuid = UUID.new
#    uuid.generate
#  end

  #def url(options={})
  #  super.split("?v=")[0]+"_v#{model.updated_at.to_time.to_i}" rescue super
  #end

  #def filename
  #  "#{secure_token}.#{file.extension}_v#{model.updated_at.to_time.to_i}" if original_filename.present?
  #end
  #
  #protected
  #
  #def secure_token
  #  var = :"@#{mounted_as}_secure_token"
  #  model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  #end
end
