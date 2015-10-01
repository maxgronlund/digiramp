# UserAssetsFactory.new user

class UserAssetsFactory
  
  def initialize user
    @user = user
    create_account
    create_label
    create_distribution_agreement
    create_distribution_agreement_document
    create_ipi
    create_publisher
    create_publishing_agreement
    create_publishing_agreement_document
    create_ipi_publisher
    create_mp3_term_of_usage
  end

  
  def create_account

    @account = Account.new(   
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
  
  def create_label
    @label = Label.create( user_id: @user.id, account_id: @account.id, title: "#{@user.user_name}'s Label")
    @user.update(default_label_id: @label.id)
     
  end
  
  def create_distribution_agreement
    @distribution_agreement = DistributionAgreement.create(
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

  def create_distribution_agreement_document
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
      title:            @distribution_agreement.title.gsub(' COPY', ''),
      expires: false
    )
    
    CopyMachine.create_document_users template, doc
    
  end
  
  def create_ipi
    @ipi = Ipi.create(
      user_id:    @user.id, 
      master_ipi: true,
      uuid:       UUIDTools::UUID.timestamp_create().to_s,
      email:      @user.email,
      full_name:  @user.full_name
    )
  end


  def create_publisher
    @publisher = Publisher.create(
      user_id: @user.id,
      account_id: @account.id,
      legal_name: "#{@user.user_name} publishing",
      email:      @user.email,
      personal_publisher: true,
      show_on_public_page: false 
    )
    @publisher.confirmed!
  end
  
  def create_publishing_agreement
    
    @publishing_agreement = PublishingAgreement.create(
      publisher_id:       @publisher.id,
      split:              50.0,
      title:              "Self publishing for #{@user.user_name}",
      personal_agreement: true,
      user_id:            @user.id,
      account_id:         @account.id, 
      uuid: UUIDTools::UUID.timestamp_create().to_s
    )
  end
  
  def create_publishing_agreement_document
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
      :belongs_to_id    => @publishing_agreement.id,
      :belongs_to_type  => @publishing_agreement.class.name,
      :account_id       => @account.id,
      :template_id      => template.id,
      title:            template.title.gsub(' COPY', ''),
      expires: false
    )
    CopyMachine.create_document_users template, doc
  end
  
  def create_ipi_publisher
    IpiPublisher.create(
      publisher_id: @publisher.id,
      ipi_id:       @ipi.id,
      publishing_agreement_id: @publishing_agreement.id
    )
  end
  
  def create_mp3_term_of_usage
    template  = Document.where(uuid: "38e2fddc-45ce-11e5-b8b5-d43d7eecec4d")
    .first_or_create(
      title: "Term of usage for a mp3 file bought in the shop",
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
      title:            template.title.gsub(' COPY', ''),
      expires: false
    )
    CopyMachine.create_document_users template, doc
  end
  
  
  
  
end