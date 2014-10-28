class Uniqifyer
  def self.uniqify not_uniq_number
    uniq_string     =   not_uniq_number.to_s
    prepend_str =  '00000000000000'.byteslice(0...-uniq_string.length)
    prepend_str + uniq_string + '_uuid_' + UUIDTools::UUID.timestamp_create().to_s
  end
end

