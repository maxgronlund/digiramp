class TransloaditDocumentsParser
  
  def initialize
  end
  

  
  def self.extract uploads
    
    if uploads[:results].nil?
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      puts 'ERROR: Unable to extract recordings: uploads nil'
      puts 'In TransloaditRecordingsParser#extract'
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      return nil 
    end
    transloadets  = []
    extracted     = {}

    
    # original file
    uploads[:results][':original'].each do |original|
      extracted[ original[:original_id] ] =  { 
                                                title:          original[:name], 
                                                file_type:      original[:type],
                                                mime:           original[:mime],
                                                file:           original[:url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp'),
                                                file_size:      original[:size]
                                              }
    end
    
    
    begin
      # thumbnail
      uploads[:results][:image_thumb].each do |image_thumb|
        extracted[ image_thumb[:original_id] ][:image_thumb] = image_thumb[:url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp')
      end
    rescue
    end
    
    
    extracted.each do | k, v|
      transloadets << v
    end

    transloadets
  end
  
  def self.parse uploads, account_id
    transloadets  = extract( uploads )
    

    documents = []
    transloadets.each do |transloaded|


      
      document =   Document.create!(  title:          transloaded[:title],
                                      file_type:      transloaded[:file_type],
                                      mime:           transloaded[:mime],
                                      file:           transloaded[:file],
                                      image_thumb:    transloaded[:image_thumb],
                                      file_size:      transloaded[:file_size],
                                      account_id:     account_id
                                    )
      

      documents << document


    end
    documents
  end

  

  
  
end