#Copy models

class CopyMachine
  
  # CopyMachine.copy_document source
  def self.copy_document source_doc
    
    doc               = source_doc.dup
    doc.title         = source_doc.title + ' COPY'
    doc.uuid          = UUIDTools::UUID.timestamp_create().to_s
    doc.document_type = 'Legal'
    doc.save
    doc
  end
  
  # CopyMachine.copy_signature source_signature
  def self.copy_signature source_signature
    
    signature            = source_signature.dup
    signature.uuid       = UUIDTools::UUID.timestamp_create().to_s
    signature.save
    signature
  end
  
end


