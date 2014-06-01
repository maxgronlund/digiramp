class TransloaditImageParser
  
  def initialize
  end
  

  def self.extract uploads
    transloadets  = []
    # original images
    if uploads[:results] && uploads[:results][:accepted_images]
      uploads[:results][:accepted_images].each do |accepted_image|
        transloadets << { file: accepted_image[:url], title: accepted_image[:name]}
      end
      
      uploads[:results][:image_thumb].each_with_index do |image_thumb, index|
        transloadets[index][:thumb] = image_thumb[:url]
      end
    else
      transloadets = nil
    end
    transloadets
  end
  
  def self.parse_images uploads, account_id, recording_id
    transloadets = extract( uploads )
    
    transloadets.each do |transloaded|
      ImageFile.create!(  account_id: account_id, 
                          recording_id: recording_id, 
                          file: transloaded[:file], 
                          thumb: transloaded[:thumb], 
                          title: transloaded[:title])
    end
  end
  
  def self.get_image_url uploads
    
    transloadets = extract( uploads )

    transloadets ? transloadets[0][:thumb] : nil
  end

end