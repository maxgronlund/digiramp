# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick


  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/fallback/" + [version_name, "default.jpg"].compact.join('_')
  end

  # Process files as they are uploaded:
  process :convert => 'jpg'
  #process :resize_to_limit => [1170, 1170]

  # Create different versions of your uploaded files:  
  cattr_accessor :version_dimensions
  self.version_dimensions = {
    :avatar_32x32     => [32,32],
    :avatar_64x64     => [64,64],
    :avatar_120x120   => [120,120],
    :avatar_170x170   => [170, 170],
    :avatar_270x270   => [270, 270],
    :avatar_370x370   => [370, 370]
  }

  RESIZE_GRAVITY = 'NorthWest'

  # define versions from dimensions above
  self.version_dimensions.keys.each do |a_version|
    eval <<-EOT
      version :#{a_version} do
        process :manualcrop
        process :resize_to_fill => self.version_dimensions[:#{a_version}] << RESIZE_GRAVITY
      end
EOT
  end

  def manualcrop
    return unless model.cropping?
    return if model.crop_params[version_name.to_sym].blank?

    model.get_crop_version!(version_name)

    manipulate_crop! do |img|
      img.crop("#{model.crop_w.to_i}x#{model.crop_h.to_i}+#{model.crop_x.to_i}+#{model.crop_y.to_i}")
    end
  end

  def manipulate_crop!
    crop_image = ::MiniMagick::Image.open(current_path)
    yield(crop_image)
    crop_image.write(current_path)
  rescue => e
    raise CarrierWave::ProcessingError.new("Failed to manipulate with MiniMagick, maybe it is not an image? Original Error: #{e}")
  end

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
