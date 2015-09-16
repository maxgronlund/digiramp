class StampDigitalSignatures < ActiveRecord::Migration
  def change
    
    DigitalSignature.find_each do |digital_signature|
      digital_signature.update(uuid: UUIDTools::UUID.timestamp_create().to_s) if digital_signature.uuid.nil?
    end
  end
end
