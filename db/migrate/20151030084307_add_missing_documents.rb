class AddMissingDocuments < ActiveRecord::Migration
  def change

    missing_publishers = 0
    missing_publishing_agreements = 0
    
    User.find_each do |user|
      if user.personal_publishing_agreement
        if user.personal_publisher
          create_personal_publishing_agreement user
        else
          missing_publishers += 1
        end
          
      else
        ap missing_publishing_agreements += 1
      end
    end
    ap '========================================================'
    ap "Missing missing_publishers: #{missing_publishers}"
    ap "Missing missing_publishing_agreements: #{missing_publishing_agreements}"
    ap '========================================================'
  end
  
  def create_personal_publishing_agreement user
    
    PublishingAgreement.create(
      publisher_id:       user.personal_publisher.id,
      split:              0.0,
      title:              "Personal publishing agreement for #{user.user_name}",
      personal_agreement: true,
      user_id:            user.id,
      account_id:         user.account_id, 
      uuid: UUIDTools::UUID.timestamp_create().to_s
    )
    create_document user
    
  end
  
  def create_document user
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
      :belongs_to_id    => user.personal_publishing_agreement.id,
      :belongs_to_type  => user.personal_publishing_agreement.class.name,
      :account_id       => user.account.id,
      :template_id      => template.id,
      title:             template.title.gsub('COPY', ''),
      expires: false
    )

    user.personal_publishing_agreement.update(document_uuid: doc.uuid)
    
    create_document_user user
    
  end
  
  def create_document_user user
    
    DocumentUser.create(
      document_id: user.personal_publishing_agreement_document.uuid,
      user_id: user.id,
      account_id: user.account_id,
      can_edit: true,
      should_sign: true,
      email: user.email,
      role: "Publisher",
      legal_name: user.get_full_name,
      ok: false
    )
  end
end
