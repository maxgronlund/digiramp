class AddSplitToDistributionAgreements < ActiveRecord::Migration
  def change
    add_column :distribution_agreements, :distribution_fee, :decimal, default: 25.0
    
    DistributionAgreement.update_all(distribution_fee: 25.0)
  end
end
