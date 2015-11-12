class AddEmailToSelfPublishingDocuments < ActiveRecord::Migration
  def change
    
    remove_foreign_key "common_work_users", "common_works"
    remove_foreign_key "common_work_users", "users"
    add_foreign_key "common_work_users", "users", on_delete: :cascade
    add_foreign_key "common_work_users", "common_works", on_delete: :cascade
    
    User.find_each do |user|
      begin
        user.save!
      rescue => e
        ap e
        ap '...'
      
        if client_invitations = ClientInvitation.where(email: user.email)
          client_invitations.destroy_all
        end
        #user.account.destroy!  
        #user.destroy
        ap '============================'
        ap user.id
      end
    end
    
    User.find_each do |user|
      begin
        secure_personal_publisher user
        
        digital_signature_id = nil
        if user.digital_signature_uuid
          if digital_signature = DigitalSignature.find_by(uuid: user.digital_signature_uuid)
            digital_signature_id = digital_signature.id
          end
        end
      rescue
        ap '-----------------'
        ap user.id
      end
      
      #if personal_publishing_agreement = user.personal_publishing_agreement
      #  begin
      #    if document = personal_publishing_agreement.document
      #      if document_user = document.document_users.find_by(role: 'Publisher')
      #        document_user.update(
      #          email:                user.email,
      #          user_id:              user.id,
      #          digital_signature_id: digital_signature_id,
      #          document_id:          document.id,
      #          account_id:           user.account.id  ,
      #          can_edit:             true,
      #          should_sign:          true,
      #        )
      #        
      #      else
      #        document_user = DocumentUser.create(
      #          email:                user.email,
      #          user_id:              user.id,
      #          digital_signature_id: digital_signature_id,
      #          document_id:          document.id,
      #          account_id:           user.account.id  ,
      #          can_edit:             true,
      #          should_sign:          true,
      #        )
      #      end
      #      document_user.accepted! 
      #    else
      #      ap "document is missing"
      #      ap user.id
      #      ap personal_publishing_agreement.id
      #      ap '---------------'
      #    end
      #  rescue
      #    ap 'AddEmailToSelfPublishingDocuments'
      #    ap personal_publishing_agreement.id
      #  end
      #else
      #  ap 'personal_publishing_agreement is missing'
      #  ap user.id
      #  ap '---------------'
      #end
    end
  end
  
  def secure_personal_publisher user

    unless user.personal_publishing_agreement
      unless personal_publisher = user.personal_publisher
        personal_publisher = Publisher.create(
          user_id:      user.id,
          account_id:   user.account.id,
          legal_name: "#{user.user_name} Publishing",
          email:      user.email,
          personal_publisher: true,
          show_on_public_page: false 
        )
        user.update_columns(personal_publisher_id: personal_publisher.id)
        #personal_publisher.confirmedpersonal_publisher
        
      end
      secure_personal_publishing_agreement user, personal_publisher
    end
  end
  
  def secure_personal_publishing_agreement user, personal_publisher
    
    
    unless publishing_agreement = user.personal_publishing_agreement 
      publishing_agreement = PublishingAgreement.create(
        publisher_id:       personal_publisher.id,
        split:              0.0,
        title:              "Publishing agreement for #{user.user_name}",
        personal_agreement: true,
        user_id:            user.id,
        account_id:         user.account_id, 
        uuid: UUIDTools::UUID.timestamp_create().to_s
      )
    end
    secure_publishing_agreement_document user, publishing_agreement
  end
  
  def secure_publishing_agreement_document user, publishing_agreement
    
    unless publishing_agreement.document
      
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
        :account_id       => user.account.id,
        :template_id      => template.id,
        title:            template.title.gsub('COPY', ''),
        expires: false
      )
      CopyMachine.create_document_users template, doc
      
      publishing_agreement.update(document_uuid: doc.uuid)
    end
  end
  
  
end
