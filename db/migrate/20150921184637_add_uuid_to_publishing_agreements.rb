class AddUuidToPublishingAgreements < ActiveRecord::Migration
  def change
    add_column :publishing_agreements, :uuid, :uuid
    
    PublishingAgreement.find_each do |publishing_agreement|
      publishing_agreement.update(uuid: UUIDTools::UUID.timestamp_create().to_s)
    end
  end
end
