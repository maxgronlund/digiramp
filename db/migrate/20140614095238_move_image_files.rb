class MoveImageFiles < ActiveRecord::Migration
  def change
    
    Recording.all.each do |recording|
      recording.image_files.each do |image_file|
        image_file_copy = copy_image_file image_file
        recording_item = RecordingItem.where(
                                              recording_id: recording.id, 
                                              itemable_id: image_file_copy.id,
                                              itemable_type: 'Artwork')
                                              .first_or_create(
                                                                recording_id: recording.id, 
                                                                itemable_id: image_file_copy.id,
                                                                itemable_type: 'Artwork'
                                                               )
        
        puts '-------------- recording item created for--------------------'
        puts recording.title
      end
    end
    
    
  end
  
  
  def copy_image_file image_file
    artwork = Artwork.create(
                               title:                    image_file.title,
                               body:                     image_file.body,
                               account_id:               image_file.account_id,
                               file:                     image_file.file,
                               created_at:               image_file.created_at,
                               updated_at:               image_file.updated_at,
                               thumb:                    image_file.thumb,
                               image_id:                 image_file.image_id,
                               basename:                 image_file.basename,
                               ext:                      image_file.ext,
                               image_size:               image_file.image_size,
                               mime:                     image_file.mime,
                               image_type:               image_file.image_type,
                               md5hash:                  image_file.md5hash,
                               width:                    image_file.width,
                               height:                   image_file.height,
                               date_recorded:            image_file.date_recorded,
                               description:              image_file.description,
                               location:                 image_file.location,
                               aspect_ratio:             image_file.aspect_ratio,
                               city:                     image_file.city,
                               state:                    image_file.state,
                               country:                  image_file.country,
                               country_code:             image_file.country_code,
                               keywords:                 image_file.keywords,
                               aperture:                 image_file.aperture,
                               exposure_compensation:    image_file.exposure_compensation,
                               exposure_mode:            image_file.exposure_mode,
                               exposure_time:            image_file.exposure_time,
                               flash:                    image_file.flash,
                               focal_length:             image_file.focal_length,
                               f_number:                 image_file.f_number,
                               iso:                      image_file.iso,
                               light_value:              image_file.light_value,
                               metering_mode:            image_file.metering_mode,
                               shutter_speed:            image_file.shutter_speed,
                               white_balance:            image_file.white_balance,
                               device_name:              image_file.device_name,
                               device_vendor:            image_file.device_vendor,
                               device_software:          image_file.device_software,
                               latitude:                 image_file.latitude,
                               longitude:                image_file.longitude,
                               orientation:              image_file.orientation,
                               has_clipping_path:        image_file.has_clipping_path,
                               creator:                  image_file.creator,
                               author:                   image_file.author,
                               copyright:                image_file.copyright,
                               frame_count:              image_file.frame_count,
                               copyright_notice:         image_file.copyright_notice
                             )
    
    artwork
  end
end
