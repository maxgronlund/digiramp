class TransloaditImageParser
  
  def initialize
  end
  

  def self.extract uploads
    transloadets  = []
    extracted     = {}
    

    # original images
    
    if uploads[:results] && uploads[:results][:accepted_images]
      uploads[:results][:accepted_images].each do |accepted_image|
        
        meta = accepted_image["meta"]
        
        extracted[ accepted_image[:original_id] ] =  { 
                                                        file:                    accepted_image[:url], 
                                                        title:                   accepted_image[:name],
                                                        basename:                accepted_image[:basename ],
                                                        ext:                     accepted_image[:ext],
                                                        image_size:              accepted_image[:image_size],
                                                        mime:                    accepted_image[:mime],
                                                        image_type:              accepted_image[:image_type],
                                                        md5hash:                 accepted_image[:md5hash],
                                                        width:                   meta["width"],
                                                        height:                  meta["height"],
                                                        date_recorded:	         meta["date_recorded"],
                                                        date_file_created:	     meta["date_file_created"],
                                                        date_file_modified:      meta["date_file_modified"],
                                                        description:	           meta["description"],
                                                        location:	               meta["location"],
                                                        aspect_ratio:            meta["aspect_ratio"],
                                                        city:		                 meta["city"],
                                                        state:	                 meta["state"],
                                                        country:	               meta["country"],
                                                        country_code:            meta["country_code"],
                                                        keywords:	               meta["keywords"],
                                                        aperture:	               meta["aperture"],
                                                        exposure_compensation:	 meta["exposure_compensation"],
                                                        exposure_mode:	         meta["exposure_mode"],
                                                        exposure_time:	         meta["exposure_time"],
                                                        flash:	                 meta["flash"],
                                                        focal_length:	           meta["focal_length"],
                                                        f_number:	               meta["f_number"],
                                                        iso:	                   meta["iso"],
                                                        light_value:	           meta["light_value"],
                                                        metering_mode:	         meta["metering_mode"],
                                                        shutter_speed:	         meta["shutter_speed"],
                                                        white_balance:	         meta["white_balance"],
                                                        device_name:	           meta["device_name"],
                                                        device_vendor:	         meta["device_vendor"],
                                                        device_software:         meta["device_software"],
                                                        latitude:	               meta["latitude"],
                                                        longitude:	             meta["longitude"],
                                                        orientation:             meta["orientation"],
                                                        has_clipping_path:	     meta["has_clipping_path"],
                                                        creator:	               meta["creator"],
                                                        author:	                 meta["author"],
                                                        copyright:	             meta["copyright"],
                                                        frame_count:	           meta["frame_count "],
                                                        copyright_notice:	       meta["copyright_notice"]
                                                      }
      end
      
      
      
      
      # thumbnail
      uploads[:results][:image_thumb].each do |image_thumb|
        extracted[ image_thumb[:original_id]][:thumb]  = image_thumb[:url]
      end
      
      
      extracted.each do | k, v|
        transloadets << v
      end
      
      
      #uploads[:results][:image_thumb].each_with_index do |image_thumb, index|
      #  transloadets[index][:thumb] = image_thumb[:url]
      #end
    else
      transloadets = nil
    end
    

    transloadets
  end
  
  def self.catalog_artwork  uploads, account_id, catalog_id
    transloadets = extract( uploads )
    artworks = []
    transloadets.each do |transloaded|

      keywords = ''
      if transloaded[:keywords]
        transloaded[:keywords].each do |keyword|
          keywords += ' '
          keywords += keyword
          keywords += ','
        end
      end
      
      artwork = Artwork.create!(  account_id:              account_id, 
                                  file:                    transloaded[:file], 
                                  thumb:                   transloaded[:thumb], 
                                  title:                   transloaded[:title],
                                  basename:                transloaded[:basename ],
                                  ext:                     transloaded[:ext],
                                  image_size:              transloaded[:image_size],
                                  mime:                    transloaded[:mime],
                                  image_type:              transloaded[:image_type],
                                  md5hash:                 transloaded[:md5hash],
                                  width:                   transloaded[:width],
                                  height:                  transloaded[:height],
                                  date_recorded:	         transloaded[:date_recorded],
                                  date_file_created:	     transloaded[:date_file_created],
                                  date_file_modified:      transloaded[:date_file_modified],
                                  description:	           transloaded[:description],
                                  location:	               transloaded[:location],
                                  aspect_ratio:            transloaded[:aspect_ratio],
                                  city:		                 transloaded[:city],
                                  state:	                 transloaded[:state],
                                  country:	               transloaded[:country],
                                  country_code:            transloaded[:country_code],
                                  keywords:	               keywords,
                                  aperture:	               transloaded[:aperture],
                                  exposure_compensation:	 transloaded[:exposure_compensation],
                                  exposure_mode:	         transloaded[:exposure_mode],
                                  exposure_time:	         transloaded[:exposure_time],
                                  flash:	                 transloaded[:flash],
                                  focal_length:	           transloaded[:focal_length],
                                  f_number:	               transloaded[:f_number],
                                  iso:	                   transloaded[:iso],
                                  light_value:	           transloaded[:light_value],
                                  metering_mode:	         transloaded[:metering_mode],
                                  shutter_speed:	         transloaded[:shutter_speed],
                                  white_balance:	         transloaded[:white_balance],
                                  device_name:	           transloaded[:device_name],
                                  device_vendor:	         transloaded[:device_vendor],
                                  device_software:         transloaded[:device_software],
                                  latitude:	               transloaded[:latitude],
                                  longitude:	             transloaded[:longitude],
                                  orientation:             transloaded[:orientation],
                                  has_clipping_path:	     transloaded[:has_clipping_path],
                                  creator:	               transloaded[:creator],
                                  author:	                 transloaded[:author],
                                  copyright:	             transloaded[:copyright],
                                  frame_count:	           transloaded[:frame_count],
                                  copyright_notice:	       transloaded[:copyright_notice]
                                )
      artworks << artwork                          
    end
    artworks
  end
  
  
  
  
  # depricate this use artwork instead
  def self.parse_images uploads, account_id, recording_id
    transloadets = extract( uploads )
    
    transloadets.each do |transloaded|

      keywords = ''
      if transloaded[:keywords]
        transloaded[:keywords].each do |keyword|
          keywords += ' '
          keywords += keyword
          keywords += ','
        end
      end
      
      ImageFile.create!(  account_id:              account_id, 
                          recording_id:            recording_id, 
                          file:                    transloaded[:file], 
                          thumb:                   transloaded[:thumb], 
                          title:                   transloaded[:title],
                          basename:                transloaded[:basename ],
                          ext:                     transloaded[:ext],
                          image_size:              transloaded[:image_size],
                          mime:                    transloaded[:mime],
                          image_type:              transloaded[:image_type],
                          md5hash:                 transloaded[:md5hash],
                          width:                   transloaded[:width],
                          height:                  transloaded[:height],
                          date_recorded:	         transloaded[:date_recorded],
                          date_file_created:	     transloaded[:date_file_created],
                          date_file_modified:      transloaded[:date_file_modified],
                          description:	           transloaded[:description],
                          location:	               transloaded[:location],
                          aspect_ratio:            transloaded[:aspect_ratio],
                          city:		                 transloaded[:city],
                          state:	                 transloaded[:state],
                          country:	               transloaded[:country],
                          country_code:            transloaded[:country_code],
                          keywords:	               keywords,
                          aperture:	               transloaded[:aperture],
                          exposure_compensation:	 transloaded[:exposure_compensation],
                          exposure_mode:	         transloaded[:exposure_mode],
                          exposure_time:	         transloaded[:exposure_time],
                          flash:	                 transloaded[:flash],
                          focal_length:	           transloaded[:focal_length],
                          f_number:	               transloaded[:f_number],
                          iso:	                   transloaded[:iso],
                          light_value:	           transloaded[:light_value],
                          metering_mode:	         transloaded[:metering_mode],
                          shutter_speed:	         transloaded[:shutter_speed],
                          white_balance:	         transloaded[:white_balance],
                          device_name:	           transloaded[:device_name],
                          device_vendor:	         transloaded[:device_vendor],
                          device_software:         transloaded[:device_software],
                          latitude:	               transloaded[:latitude],
                          longitude:	             transloaded[:longitude],
                          orientation:             transloaded[:orientation],
                          has_clipping_path:	     transloaded[:has_clipping_path],
                          creator:	               transloaded[:creator],
                          author:	                 transloaded[:author],
                          copyright:	             transloaded[:copyright],
                          frame_count:	           transloaded[:frame_count],
                          copyright_notice:	       transloaded[:copyright_notice]
                          
                        )
    end
  end
  
  
  
  def self.get_image_url uploads
    
    transloadets = extract( uploads )

    transloadets ? transloadets[0][:thumb] : nil
  end

end