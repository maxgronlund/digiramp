#Copy models

class CopyMachine
  
  # CopyMachine.copy_document source
  def self.copy_document source_doc
    return nil if source_doc.nil?
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
    document_users = []
    if digital_signatures = source_doc.digital_signatures
      
      digital_signatures.each do |digital_signature|
        document_user = DocumentUser.new(
          document_id:    dest_doc.uuid,
          can_edit:       true,
          should_sign:    true,
          role:           digital_signature.role
        )
        document_user.save(validate: false)
        document_users << document_user
      end
      
    end
    document_users
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
    
    UserPublisher.where(
      publisher_id: publisher_id,
      user_id:      publisher.user_id
    )
    .first_or_create(
      publisher_id: publisher_id,
      user_id:      publisher.user_id,
      email:       publisher.email
    )
  end
  
  def self.setup_publishing_agreement(publisher_id, personal_agreement, title, user)
    PublishingAgreement.create(
      publisher_id:       publisher_id,
      split:              50.0,
      title:              title,
      personal_agreement: personal_agreement,
      user_id:            user.id,
      account_id:         user.account.id, 
      uuid: UUIDTools::UUID.timestamp_create().to_s
    )
  end
  
  def self.setup_publishing_documents( publisher, uuid, publishing_agreement )

    template  = Document.where(uuid: uuid)
    .first_or_create(
      uuid:               uuid,
      title:              'Artist publicity agreement',
      body:               'ARTIST PUBLICITY AGREEMENT',
      text_content:       'This Agreement shall be effective as of the date set forth herein...',
      expires:            false,
      tag:                'Publishing',
      document_type:      'Template'
    )
    doc       = CopyMachine.copy_document( template )
    
    doc.update( 
        belongs_to_id:      publishing_agreement.id,
        belongs_to_type:    publishing_agreement.class.name,
        account_id:         publishing_agreement.account_id,
        template_id:        template.id,
        title:              template.title.gsub("COPY", "- #{doc.id}"),
        expires:            false
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


