class AddDistributionAgreementUuidToDistributionAgreements < ActiveRecord::Migration
  def change
    add_column :distribution_agreements, :distribution_agreement_uuid, :uuid
  end
end
