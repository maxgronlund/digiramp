#Copy models

class CopyMachine
  
  # CopyMachine.copy_document source
  def self.copy_document source_doc
    
    doc               = source_doc.dup
    doc.title         = source_doc.title + ' COPY'
    doc.uuid          = UUIDTools::UUID.timestamp_create().to_s
    doc.document_type = 'Legal'
    doc.save
    doc
  end
  
  # CopyMachine.copy_signature source_signature
  def self.copy_signature source_signature
    signature            = source_signature.dup
    signature.uuid       = UUIDTools::UUID.timestamp_create().to_s
    signature.save
    signature
  end
  
  
  # CopyMachine.create_document_users source_doc, dest_doc
  def self.create_document_users source_doc, dest_doc
    if digital_signatures = source_doc.digital_signatures
      digital_signatures.each do |digital_signature|
        document_user = DocumentUser.new(
          document_id:    dest_doc.uuid,
          account_id:     dest_doc.account_id,
          can_edit:       true,
          should_sign:    true,
          role:           digital_signature.role
        )
        document_user.save(validate: false)
      end
    end
    
  end
  
  
  
  
  
  
  #CopyMachine.setup_personal_publishing user
  def self.setup_personal_publishing user_id
    
    user = User.find(user_id)
    
    begin
      publisher = Publisher.create(
                     user_id: user.id,
                     account_id: user.account.id,
                     legal_name: "Personal publisher for #{user.user_name}",
                     email:      user.email,
                     personal_publisher: true,
                     show_on_public_page: false 
                   )
       
      publisher.confirmed!
    rescue
      publisher = Publisher.new(
                     user_id: user.id,
                     account_id: user.account.id,
                     legal_name: "Personal publisher for #{user.user_name}",
                     email:      user.email,
                     personal_publisher: true,
                     show_on_public_page: false 
                   )
      publisher.save(validate: false) 
      
      ap user.email
    end
    publishing_agreement = setup_publishing_agreement(
      publisher.id, 
      true,
      "Self publishing",
      user
    )
    doc = setup_publishing_documents( 
      publisher,
      '5dcab336-5dd6-11e5-88f3-d43d7eecec4d',
      publishing_agreement
    )
    
    doc.document_users.each do |document_user|
      document_user.update(user_id: user.id, account_id: user.account.id, email: user.email, legal_name: user.full_name)
    end

  end
  # CopyMachine.setup_publisher publisher_id
  def self.setup_publisher publisher_id
    
    publisher = Publisher.find(publisher_id)
    publisher.confirmed!
    publishing_agreement = setup_publishing_agreement(
      publisher.id, 
      false,
      'Default publishing agreement',
      publisher.user
    )
    setup_publishing_documents( 
      publisher,
      '34debb4c-5e09-11e5-a542-d43d7eecec4d',
      publishing_agreement
    )

  end
  
  def self.setup_publishing_agreement(publisher_id, personal_agreement, title, user)
    PublishingAgreement.create(
      publisher_id:       publisher_id,
      split:              100.0,
      title:              title,
      personal_agreement: personal_agreement,
      user_id:            user.id,
      account_id:         user.account.id, 
    )
  end
  
  def self.setup_publishing_documents( publisher, uuid, publishing_agreement )

    template  = Document.find_by(uuid: uuid)
    doc       = CopyMachine.copy_document( template )
    
    doc.update( 
        :belongs_to_id    => publishing_agreement.id,
        :belongs_to_type  => publishing_agreement.class.name,
        :account_id       => publishing_agreement.account_id,
        :template_id      => template.id,
        title:            template.title.gsub(' COPY', ''),
        expires: false
    )
    
    template.digital_signatures.each do |digital_signature|
      document_user = DocumentUser.new(
        :document_id => doc.uuid,
          :user_id => nil,
       :account_id => publishing_agreement.account_id,
         :can_edit => true,
      :should_sign => true,
            :email => nil,
             :role => digital_signature.role,
       :legal_name => nil

      )
      document_user.save(validate: false)
    end
    
    doc
    
  end
  
end


