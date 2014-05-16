# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
    
    storage :file
    # storage :fog
    
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
end