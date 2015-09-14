class AddDigitalSignatureIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :digital_signature_uuid, :uuid
    
    User.find_each do |user|
      
      if digital_signature = user.digital_signatures.first
        user.update(digital_signature_uuid:  digital_signature.uuid)
      end
    end
  end
end
