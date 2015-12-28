# UserAssetsFactory.new user

class UserAssetsFactory
  # create all the classes required for a new user
  def initialize user
    @user = user
    if @user.confirmation_token.nil?
      @user.update_columns(
        confirmation_token: UUIDTools::UUID.timestamp_create().to_s
      )
    end
   
    create_account
    create_label
    create_distribution_agreement
    create_distribution_agreement_document
    create_ipi
    create_publisher
    create_user_publisher
    create_publishing_agreement
    create_publishing_agreement_document
    create_ipi_publisher
    create_mp3_term_of_usage
    attach_to_documents
    @user.update_meta
    @user.save
  end

  # create the account
  def create_account

    @account = Account.where(
      user_id: @user.id
    )
    .first_or_create(   
      title: @user.user_name, 
      user_id: @user.id, 
      expiration_date: Date.current()>>1,
      contact_email: @user.email,
      visits: 1,
      account_type: 'Social',
      administrator_id: @user.id,
      create_opportunities: false,
      read_opportunities: false
    )
                      
    @account.save(validate: false)    

    # set permissions
    AccessManager.add_users_to_new_account @account
    @user.update(current_account_id: @account.id)


  end
  
  # create a label
  def create_label
    return if @label = Label.find_by(id: @user.default_label_id )
    
    @label = Label.where(
      user_id: @user.id, 
      account_id: @account.id
    )
    .first_or_create( 
      user_id: @user.id, 
      account_id: @account.id, 
      title: "#{@user.user_name}'s Label"
    )
    @user.update(default_label_id: @label.id)
     
  end
  
  # create a distribution agreement
  def create_distribution_agreement

    
    @distribution_agreement = DistributionAgreement.where(
      :label_id           => @label.id,
      :account_id         => @account.id
    )
    .first_or_create(
      :label_id           => @label.id,
      :account_id         => @account.id,
      :distributor_id     => @label.id,
      :split              => 50,
      :user_id            => @user.id,
      :title              => "Label agreement for #{@user.user_name}",
      :uuid               => UUIDTools::UUID.timestamp_create().to_s
      
    )
    @label.update(default_distribution_agreement_id: @distribution_agreement.id)
  end

  # create the documents fot a distribution agreement
  def create_distribution_agreement_document
    
    return if @distribution_agreement.documents
    
    template  = Document.where(uuid: "38e2814a-45ce-11e5-b8b5-d43d7eecec4d")
    .first_or_create(
      title: "Self Distribution",
      document_type: "Template",
      body: "You represent and warrant that you are free to enter into and abide by the \r\nterms of this Agreement and that you are the sole owner of the master recordings embodying the following compositions",
      text_content: "DISTRIBUTION AGREEMENT",
      tag: "Distribution",
      uuid: "38e2814a-45ce-11e5-b8b5-d43d7eecec4d",
    )

    doc       = CopyMachine.copy_document( template )

    doc.update( 
      :belongs_to_id    => @distribution_agreement.id,
      :belongs_to_type  => @distribution_agreement.class.name,
      :account_id       => @account.id,
      :template_id      => template.id,
      title:            @distribution_agreement.title.gsub('COPY', ''),
      expires: false
    )
    set_document_user( CopyMachine.create_document_users( template, doc ) , 'DISTRIBUTOR')

    
  end
  
  def create_ipi
    @ipi = Ipi.where(
      user_id:    @user.id,
      email:      @user.email
    )
    .first_or_create(
      user_id:    @user.id, 
      uuid:       UUIDTools::UUID.timestamp_create().to_s,
      email:      @user.email,
      full_name:  @user.full_name
    )
  end

  def create_publisher
    return if @publisher = @user.personal_publisher
    
    @publisher = Publisher.create(
      user_id: @user.id,
      account_id: @account.id,
      legal_name: "#{@user.user_name} Publishing",
      email:      @user.email,
      personal_publisher: true,
      show_on_public_page: false 
    )
    @user.update(personal_publisher_id: @publisher.id)
    @publisher.confirmed!
  end
  
  def create_user_publisher
    UserPublisher.where(
      user_id:      @user.id,
      publisher_id: @publisher.id
    )
    .first_or_create(
      user_id:      @user.id,
      publisher_id: @publisher.id,
      email:        @user.email
    )
  end
  
  def create_publishing_agreement

    return if @publishing_agreement = PublishingAgreement.find_by(
      user_id:            @user.id,
      account_id:         @account.id, 
    )
    
    @publishing_agreement = PublishingAgreement.create(
      publisher_id:       @publisher.id,
      split:              50.0,
      title:              "Publishing agreement for #{@user.user_name}",
      personal_agreement: true,
      user_id:            @user.id,
      account_id:         @account.id, 
      uuid: UUIDTools::UUID.timestamp_create().to_s
    )
  end
  
  def create_publishing_agreement_document
    
    return if @publishing_agreement.document_uuid
    
    
    if  template  = Document.where(uuid: '5dcab336-5dd6-11e5-88f3-d43d7eecec4d')
      .first_or_create(
        title: "Self publishing",
        document_type: "Template",
        body: "Self publishing ( I validate i'm my own rightful publisher )",
        text_content: "Self publishing ( I validate i'm my own rightful publisher )",
        tag: "Publishing",
        uuid: "5dcab336-5dd6-11e5-88f3-d43d7eecec4d",
      )
   
    
      if doc = CopyMachine.copy_document( template )
        
        doc.update( 
          :belongs_to_id    => @publishing_agreement.id,
          :belongs_to_type  => @publishing_agreement.class.name,
          :account_id       => @account.id,
          :template_id      => template.id,
          title:            template.title.gsub('COPY', ''),
          expires:          false
        )
        set_document_user( CopyMachine.create_document_users( template, doc ) , 'Publisher')
         
      else
        ap 'unable to copy template'
      end
    else
      ap 'unable to get template'
    end
    #if document_users = CopyMachine.create_document_users( template, doc )
    #  if document_user = document_users.first
    #    document_user.update(
    #      email:          @user.email,
    #      account_id:     @user.account_id,
    #      user_id:        @user.id, 
    #      legal_name:     @user.get_full_name
    #    )
    #    ap document_user
    #  end
    #end
    @publishing_agreement.update(document_uuid: doc.uuid)
    
    
    
  end
  
  def create_ipi_publisher
    
    IpiPublisher.where(
      publisher_id: @publisher.id,
      ipi_id:       @ipi.id,
    )
    .first_or_create(
      publisher_id: @publisher.id,
      ipi_id:       @ipi.id,
      publishing_agreement_id: @publishing_agreement.id
    )
  end
  
  def create_mp3_term_of_usage
    
    return if @account.documents.find_by(title: "Sale of mp3 for personal usage")
    
    template  = Document.where(uuid: "38e2fddc-45ce-11e5-b8b5-d43d7eecec4d")
    .first_or_create(
      title: "Sale of mp3 for personal usage",
      document_type: "Template",
      body: "You what you can use a mp3 for",
      text_content: "MP3 usage agreement",
      account_id: User.system_user.account_id,
      file_size: 0,
      tag: "Recording",
      uuid: "38e2fddc-45ce-11e5-b8b5-d43d7eecec4d",
    )
    doc       = CopyMachine.copy_document( template )
    
    doc.update( 
      :belongs_to_id    => @account.id,
      :belongs_to_type  => @account.class.name,
      :account_id       => @account.id,
      :template_id      => template.id,
      title:            template.title.gsub('COPY', ''),
      expires: false
    )
    #CopyMachine.create_document_users template, doc 

    
  end
  
  def attach_to_documents
    if document_users = DocumentUser.where(email: @user.email)
      document_users.update_all(
        user_id: @user.id, 
        account_id: @user.account_id
      )
      @user.update(has_unsigned_documents: true)
    end
    
  end
  
  def set_document_user document_users, role
    document_users.each do |document_user|
      if document_user.role == role
         document_user.update(
          email:          @user.email,
          user_id:        @user.id, 
          legal_name:     @user.get_full_name
        )
        
      end
    end
    
  end

  
end