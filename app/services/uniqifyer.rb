class Uniqifyer
  def self.uniqify not_uniq_number
    uniq_string     =   not_uniq_number.to_s
    prepend_str =  '00000000000000'.byteslice(0...-uniq_string.length)
    prepend_str + uniq_string + '_uuid_' + UUIDTools::UUID.timestamp_create().to_s
  end
  
  def self.uniqify_string not_uniq_string
    not_uniq_string + UUIDTools::UUID.timestamp_create().to_s
  end
  
  def self.ununiqify_string uniq_string
    
    uniq_string.byteslice(0...-36)
    
  end
  
end

#

