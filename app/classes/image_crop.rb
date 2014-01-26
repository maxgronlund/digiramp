module ImageCrop
  
  def self.included(base)
    base.class_eval "attr_accessor :crop_x, :crop_y, :crop_h, :crop_w, :crop_version"
    base.class_eval "before_validation :update_crop_params, :if => :cropping?"
    base.class_eval "before_validation :remove_crop_params, :if => :image_updated?"
    base.class_eval "after_update :reprocess_image, :if => :cropping?"
  end

  def get_crop_version!(version_name)
    %w(crop_x crop_y crop_w crop_h).map do |attr_name|
      self.send "#{attr_name}=".to_sym, crop_params[version_name.to_sym][attr_name.to_sym]
    end if crop_params and crop_params[version_name.to_sym].present?
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def image_geometry
    img = MiniMagick::Image.open(self.image.current_path)
    @geometry = {:width => img[:width], :height => img[:height] }
  end

  private

  def reprocess_image
    self.image.recreate_versions!
  end

  def remove_crop_params
    self.crop_params = {}
  end

  def update_crop_params
    if crop_version.present?
      crop_params[crop_version.to_sym] = {
        crop_x: crop_x.to_i,
        crop_y: crop_y.to_i,
        crop_w: crop_w.to_i,
        crop_h: crop_h.to_i,
      }
    end
  end

  def image_updated?
    changed_attributes.include? 'image'
  end
end
