class SetDefaultAgreementOnPublishingAgreements < ActiveRecord::Migration
  def change
    
    PublishingAgreement.find_each do |publishing_agreement|
      if document = publishing_agreement.documents.last
        publishing_agreement.update_columns(document_uuid: document.uuid)
      end
    end
  end
end
