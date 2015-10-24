class SetDocumentUuidOnPublishingAgreements < ActiveRecord::Migration
  def change
    
    Publisher.find_each do |publisher|
      
      if publishing_agreement = publisher.publishing_agreements.where(personal_agreement: true).first
        
        if document = publishing_agreement.documents.first
         
        else document = create_publishing_agreement_document( publishing_agreement)
          
        end 
        publishing_agreement.update_columns(
           document_uuid: document.uuid
        )
      end
    end
  end
  
  def create_publishing_agreement_document publishing_agreement
    template  = Document.where(uuid: '5dcab336-5dd6-11e5-88f3-d43d7eecec4d')
    .first_or_create(
      title: "Self publishing",
      document_type: "Template",
      body: "Self publishing ( I validate i'm my own rightful publisher )",
      text_content: "Self publishing ( I validate i'm my own rightful publisher )",
      tag: "Publishing",
      uuid: "5dcab336-5dd6-11e5-88f3-d43d7eecec4d",
    )
    doc       = CopyMachine.copy_document( template )
  
    doc.update( 
      :belongs_to_id    => publishing_agreement.id,
      :belongs_to_type  => publishing_agreement.class.name,
      :account_id       => publishing_agreement.account_id,
      :template_id      => template.id,
      title:            template.title.gsub(' COPY', ''),
      expires: false
    )
    CopyMachine.create_document_users template, doc
    if document_user = doc.document_users.first
      if publisher = publishing_agreement.publisher
        document_user.update_column(email: publisher.email)
      end
    end
    
  end
end
