class AddCopyrightToImageFiles < ActiveRecord::Migration
  def change     	
    add_column :image_files, :image_id                    , :string
    add_column :image_files, :basename                    , :string
    add_column :image_files, :ext                         , :string
    add_column :image_files, :image_size                  , :string
    add_column :image_files, :mime                        , :string
    add_column :image_files, :image_type                  , :string
    add_column :image_files, :md5hash                     , :string
    
    add_column :image_files, :width                       , :string
    add_column :image_files, :height                      , :string
    add_column :image_files, :date_recorded	              , :string
    add_column :image_files, :date_file_created	          , :string
    add_column :image_files, :date_file_modified          , :string
    add_column :image_files, :description	                , :string
    add_column :image_files, :location	                  , :string
    add_column :image_files, :aspect_ratio                , :string
    add_column :image_files, :city		                    , :string
    add_column :image_files, :state	                      , :string
    add_column :image_files, :country	                    , :string
    add_column :image_files, :country_code	              , :string
    add_column :image_files, :keywords	                  , :text
    add_column :image_files, :aperture	                  , :string
    add_column :image_files, :exposure_compensation	      , :string
    add_column :image_files, :exposure_mode	              , :string
    add_column :image_files, :exposure_time	              , :string
    add_column :image_files, :flash	                      , :string
    add_column :image_files, :focal_length	              , :string
    add_column :image_files, :f_number	                  , :string
    add_column :image_files, :iso	                        , :string
    add_column :image_files, :light_value	                , :string
    add_column :image_files, :metering_mode	              , :string
    add_column :image_files, :shutter_speed	              , :string
    add_column :image_files, :white_balance	              , :string
    add_column :image_files, :device_name	                , :string
    add_column :image_files, :device_vendor	              , :string
    add_column :image_files, :device_software             , :string
    add_column :image_files, :latitude	                  , :string
    add_column :image_files, :longitude	                  , :string
    add_column :image_files, :orientation                 , :string  
    add_column :image_files, :has_clipping_path	          , :string
    add_column :image_files, :creator	                    , :string
    add_column :image_files, :author	                    , :string
    add_column :image_files, :copyright	                  , :string
    add_column :image_files, :frame_count                 , :string
    add_column :image_files, :copyright_notice	          , :text
    
    
    
  end
end




