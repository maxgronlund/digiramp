# encoding: utf-8

class ZipUploader < CarrierWave::Uploader::Base
    #storage :file
    
    storage :fog
    
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
    
    process :save_content_type_and_size_in_model
    
    def save_content_type_and_size_in_model
        model.content_type  = file.content_type if file.content_type
        model.file_size     = file.size
    end
    
    def extension_white_list
      %w(zip)
    end
    
end