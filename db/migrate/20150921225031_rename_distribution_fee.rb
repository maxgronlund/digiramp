class RenameDistributionFee < ActiveRecord::Migration
  def change
    rename_column :distribution_agreements, :distribution_fee, :split
    change_column :distribution_agreements, :split, :decimal, default: 50.0
    add_column :distribution_agreements, :uuid, :uuid
    
    DistributionAgreement.update_all(distribution_agreement_uuid: nil)
    
    DistributionAgreement.find_each do |distribution_agreement|
      distribution_agreement.update(uuid: UUIDTools::UUID.timestamp_create().to_s)
    end
  end
end
