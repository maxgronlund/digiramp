class DefaultContent
  
  
  def self.build_default_legal_templates
    
    
    Document.where( title:          'MP3 for personal usage', 
                    body:           'Term of usage for a mp3 file bought in the shop', 
                    text_content:   'please fill in',
                    tag:            'Recording',
                    document_type:  'Template')
            .first_or_create( title: 'MP3 for personal usage', 
                    body:           'Term of usage for a mp3 file bought in the shop', 
                    text_content:   'please fill in',
                    tag:            'Recording',
                    document_type:  'Template')
                    
    
     Document.where( title:         'Physical product', 
                    body:           'Term of usage for a physical product bought in the shop', 
                    text_content:   'please fill in',
                    tag:            'Product',
                    document_type:  'Template')
            .first_or_create( title: 'Physical product', 
                    body:           'Term of usage for a physical product bought in the shop', 
                    text_content:   'please fill in',
                    tag:            'Product',
                    document_type:  'Template')
                    
    
     Document.where( title:         'Service', 
                    body:           'Term of usage for a service bought in the shop', 
                    text_content:   'please fill in',
                    tag:            'Service',
                    document_type:  'Template')
            .first_or_create( title: 'Service', 
                    body:           'Term of usage for a service bought in the shop', 
                    text_content:   'please fill in',
                    tag:            'Service',
                    document_type:  'Template')
                    
    
     Document.where( title:         'Streaming', 
                    body:           'Term of usage for a streaming bought in the shop', 
                    text_content:   'please fill in',
                    tag:            'Service',
                    document_type:  'Template')
            .first_or_create( title: 'Streaming', 
                    body:           'Term of usage for a streaming bought in the shop', 
                    text_content:   'please fill in',
                    tag:            'Service',
                    document_type:  'Template')
                    
    
    
                    
  end
  
  def self.build_default_tags
    Admin::LegalTag.where(title: 'Recording', body: 'Sale and licences for recordings')
                   .first_or_create(title: 'Recording', body: 'Sale and licences for recordings')
    Admin::LegalTag.where(title: 'Physical product', body: 'Sale and licences for physical products')
                   .first_or_create(title: 'Physical product', body: 'Sale and licences for physical products')
    Admin::LegalTag.where(title: 'Service', body: 'Terms for sale of services')
                   .first_or_create(title: 'Service', body: 'Sale of services')
    Admin::LegalTag.where(title: 'Streaming', body: 'Terms for usage of streaming')
                   .first_or_create(title: 'Streaming', body: 'Terms for usage of streaming')
                   
  end
  
end

# DefaultContent.build_default_legal_templates
# DefaultContent.build_default_tags