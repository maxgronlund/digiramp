# encoding: utf-8

class ArtworkUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  #include Sprockets::Helpers::RailsHelper
  #include Sprockets::Helpers::IsolatedHelper
  
  # Choose what kind of storage to use for this uploader:
  storage :file
  #storage :fog

  #include CarrierWave::MimeTypes
  
  #process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/images/fallback/" + [version_name, "artwork.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  process :convert => 'jpg'
  #process :resize_to_limit => [1170, 1170]

  # Create different versions of your uploaded files:  
  cattr_accessor :version_dimensions
  self.version_dimensions = {
    :size_62x62     => [62,62],
    :size_302x174   => [302, 174],
    :size_370x272   => [370, 272],
    :size_423x228   => [423, 228],
    :size_481x430   => [481, 430],
    :size_470x346   => [470, 346],
    :size_570x320   => [570, 320], # 16/9 format
    :size_600x400   => [600, 400],
    :size_770x567   => [770, 567],
    :size_870x489   => [870, 489],
    :size_1170x377  => [1170, 377],
    :size_1170x658  => [1170, 658]
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
