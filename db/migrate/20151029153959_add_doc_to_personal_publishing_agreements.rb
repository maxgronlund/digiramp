class AddDocToPersonalPublishingAgreements < ActiveRecord::Migration
  def change
    
    PublishingAgreement.where(
      personal_agreement: true).each do |publishing_agreement|
        
        unless documents = publishing_agreement.documents
      
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
            title:            template.title.gsub('COPY', ''),
            expires: false
          )
          set_document_user( CopyMachine.create_document_users( template, doc ) , 'Publisher')
          publishing_agreement.update(document_uuid: doc.uuid)
        end
        
      end
    
  end
  
  def set_document_user document_users, role
    document_users.each do |document_user|
      if document_user.role == role
         document_user.update(
          email:          document_users.user.email,
          user_id:        document_users.user.id, 
          legal_name:     document_users.user.get_full_name
        )
        
      end
    end
    
  end
end
