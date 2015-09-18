class AttachIpiPublisherAgreements < ActiveRecord::Migration
  def up
    IpiPublishingAgreement.destroy_all
    
    Ipi.where(master_ipi: true).each do |ipi|
      
      if ipi.email 
        if user =  ipi.user
          # I assume this is a self published ip
          if ipi.email == user.email
            ipa = IpiPublishingAgreement.create(ipi_id: ipi.id, publishing_agreement_id: user.personal_publishing_agreement.id)
            ap ipa
          end
        end
      end
    
    end
  end
  
  def down
    
  end
end
