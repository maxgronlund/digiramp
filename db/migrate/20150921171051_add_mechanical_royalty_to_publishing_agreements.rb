class AddMechanicalRoyaltyToPublishingAgreements < ActiveRecord::Migration
  def change
    add_column :publishing_agreements, :mechanical_royalty, :decimal, default: 10.0
    
    
    
    change_column :publishing_agreements, :split, :decimal, default: 50.0
    
    PublishingAgreement.update_all(mechanical_royalty: 10.0, split: 50.0)
  end
end
