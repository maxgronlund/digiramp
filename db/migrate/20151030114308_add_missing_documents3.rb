class AddMissingDocuments3 < ActiveRecord::Migration
  def change
   
    
    User.find_each do |user|
      if personal_publishing_agreement = user.personal_publishing_agreement
        if personal_publishing_agreement.document
          
        else
          create_document user
        end
      end
    end
   
  end
  
  
  def create_document user
    ap "create_document for #{user.user_name}"
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
    ap "create_document_user for #{user.user_name}"
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
