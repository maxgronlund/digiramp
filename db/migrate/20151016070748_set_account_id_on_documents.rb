class SetAccountIdOnDocuments < ActiveRecord::Migration
  def change
    
    PublishingAgreement.find_each do |publishing_agreement|
      
      publishing_agreement.documents.each do |document|
        document.update(account_id: publishing_agreement.account_id)
      end
      
    end
  end
end
