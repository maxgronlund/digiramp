# This class validates a recording by iterating true all the associated data. 
# ==== Example
#  sales_service = SalesService.new(RECORDING_ID)
#  # => {
#          :status => 'ok',
#     :common_work => {
#                   :status => 'error',
#                       :id => '11830',
#                    :title => '00 4'
#                    }
#     ...
# When a model associated with a recording is changed 
# this service class should be created and validate should be called
# Then a message descriping problems if any will be generated
# and stored in a user_notification record

class SalesService
  
  # Create the SalesService validator
  def initialize recording_id
    
    if @recording = Recording.cached_find(recording_id)
      validate
    else
      {
        status: 'error',
        message: 'Recording not found'
      }
    end
  end
  
  # Entry point for a validation cycle
  #
  # * Is is the commen_work 100% cleared
  # * is the recording 100% cleared
  # * Build a user message if the work is not valid
  def validate

    status = 'ok'
    
    validated_work = validate_work
    if validated_work[:status] == 'error'
      status = 'error'
    end
    
    validated_recording = validate_recording
    if validated_recording[:status] == 'error'
      status = 'error'
    end 
    
    @message = {
      status: status,
      common_work: validated_work,
      recording: validated_recording
    }
    update_user_notification
  end
  
  # Create. Delete or Update UserNotification
  def update_user_notification
    
    if user_notification = UserNotification.find_by(
        user_id:        @recording.user_id,
        asset_id:       @recording.id,
        asset_type:     @recording.class.name,
        
      )
      if @message[:status] == 'ok'
        user_notification.destroy 
      else
        user_notification.update(
          error_message: @message,
          message:       'Recording not ready for sale'
        )
      end
    elsif @message[:status] == 'error'
       user_notification = UserNotification.create(
         user_id:        @recording.user_id,
         asset_id:       @recording.id,
         asset_type:     @recording.class.name,
         error_message:  @message,
         message:       'Recording not ready for sale'
       )
    end
    ap user_notification if user_notification
  end
  
  
  
  # Check if the recording is 100% cleared
  def validate_recording
    if recording_ipis = @recording.recording_ipis
      validated_recording_ipis = []
      status = 'ok'
      message = ''
      recording_ipis.each do |recording_ipi|
        validated_recording_ipi = validate_recording_ipi recording_ipi
        validated_recording_ipis << validated_recording_ipi
        if validated_recording_ipi[:status] == 'error'
          status = 'error'
        end
        unless @recording.contributors_share == 100.0
          status = 'error'
          message = 'The sum of all contributers share should be 100%'
        end
      end
      
      {
        status:             status,
        message:            message,
        id:                 @recording.id,
        titel:              @recording.title,
        recording_ipis:     validated_recording_ipis
        
      }
    else
      {
        status: 'error',
        id:     @recording.id,
        titel:  @recording.title,
        message: 'No creators assigned to the recording'
        
      }
    end
    
  end
  
  # Check one recording ipi
  def validate_recording_ipi recording_ipi
    {
      status: 'ok',
      id:      recording_ipi.id,
      user:    validate_recording_ip_user( recording_ipi )
    }
  end
  
  
  # Check if the recording ipi is connected to a user
  def validate_recording_ip_user recording_ipi
    if user = recording_ipi.user
      {
        
        status: 'ok',
        user_name: user.full_name
        
      }
    else
      {
        status: 'error',
        message: 'User missing'
      }
    end
  
  end
  
  def validate_common_work common_work_id
    begin
      @common_work = CommonWork.cached_find(common_work_id)
      validated_common_work = validate_common_work_ipis( @common_work )
      validated_common_work[:status] == 'error' ? status = 'error' : status = 'ok'

      {
        status:           status,
        id:               @common_work.id,
        title:            @common_work.title,
        common_work_ipis: validated_common_work[:common_work_ipis]
      }
    rescue
    
    end
    
    
  end
  
  
  # Check if the work exists
  def validate_work
    if @common_work = @recording.common_work
      
      validated_common_work = validate_common_work_ipis( @common_work )
      validated_common_work[:status] == 'error' ? status = 'error' : status = 'ok'

      {
        status:           status,
        id:               @common_work.id,
        title:            @common_work.title,
        common_work_ipis: validated_common_work[:common_work_ipis]
      }
      
      
    else 
      return {
        status: 'error',
        message: "Work is missing for #{recording.title}"
      }
    end
  end
  
  
  
  
  # Check if all common_work_ips are valid
  def validate_common_work_ipis common_work
    validated_common_work_ipis = []
    status = 'ok'
    
    if common_work_ipis = common_work.common_work_ipis
      
      common_work_ipis.each do |common_work_ipi|
        validated_common_work_ipi  = validate_common_work_ipi( common_work_ipi) 
        validated_common_work_ipis << validated_common_work_ipi 
        
        if validated_common_work_ipi[:status] == 'error'
          status = 'error' 
        end
      end
      {
        status: status,
        common_work_ipis: validated_common_work_ipis
      }
    
    else
      { 
        status: 'error',
        message: "No creators registered for #{common_work.title}"
      }
    end
  end
  
 
  
  # Check if there an ipi associated with a common_work_ipi
  def validate_common_work_ipi common_work_ipi
    
    if ipi = common_work_ipi.ipi
      
      validated_ipi = validate_ipi(ipi)
      { 
        status:              validated_ipi[:status],
        ipi:                  validated_ipi
      }
    else
      {
        status: 'error',
        message: 'No ipi attached'
      }
    end
   
  end
  
  # Print the resoult for the check for valid ip publishers
  def validate_ipi ipi
    status = 'ok'
    validated_ipi_publishers = validate_ipi_publishers( ipi )
    
    if validated_ipi_publishers[:status] == 'error'
      status = 'error'
    end
    {
      status: status,
      id: ipi.id, 
      publishers: validated_ipi_publishers[:publishers]
    }
  end
  
  # Check if the is valid publishers for an ip
  def validate_ipi_publishers ipi
    _publishers = []
    status = 'ok'
    if pubs = ipi.publishers
      
      pubs.each do |publisher|
        validate_ipi_publisher = validate_ipi_publisher( publisher, ipi )
        _publishers << validate_ipi_publisher
        if validate_ipi_publisher[:status] == 'error'
          status = 'error'
        end
        
      end
      {
        status: status,
        publishers: _publishers
      }
      
    else
      {
       status: 'error',
       message: 'No publishers attached'
      }
    end
    
  end
  
  # Check one ip_publisher
  def validate_ipi_publisher publisher, ipi
    
    status = 'ok'
    
    if publishing_agreements = publisher.publishing_agreements
      
      
      _publishing_agreements = []
      
      publishing_agreements.each do |publishing_agreement|
        
        validated_publishing_agreement =  validate_publishing_agreements(publishing_agreement, ipi )
        
        _publishing_agreements         << validated_publishing_agreement
        
        if validated_publishing_agreement[:status] == 'error'
           status = 'error'
        end
      end
      
      
      {
        status:                 status,
        id:                     publisher.id,
        legal_name:             publisher.legal_name,
        publishing_agreements:  _publishing_agreements
      }
    else
      {
        status:     'error',
        message:    'The publisher has no publishing agreements',
        id:         publisher.id,
        legal_name: publisher.legal_name
      }
    end
  end
  

  # Check if one publishing agreement is valid
  def validate_publishing_agreements publishing_agreement, ipi
    
    if document = publishing_agreement.document
      
      validated_document = validate_document( document, ipi )
      
      {
        status:     validated_document[:status],
        id:         publishing_agreement.id,
        document:   validated_document
      }
    else
      {
        status:     'error',
        message:    'No documents attached to publishing agreement',
        id:         publishing_agreement.id,
      }
    end

  end
  
  # check if a document is signed
  def validate_document document, ipi
    if document.signed?
      {
        status: 'ok',
        title:  document.title,
        id:     document.uuid
      }
    else
      {
       status: 'error',
       message: 'Document not signed',
       title:  document.title,
       id:     document.uuid,
       document_users: validate_document_users( document )
      }
    end
    
  end
  
  
  def validate_document_users document
    if document_users = document.document_users
      validated_document_users = []
      document_users.each do |document_user|
        validated_document_users << validate_document_user( document_user )
      end
      return validated_document_users
    else
      {
        status: 'error',
        message: 'No users added to the document'
      }
    end

  end
  
  def validate_document_user document_user
    if( document_user.should_sign && document_user.digital_signature_id.nil?)
      if user = document_user.user
        {
          status:   'error',
          message:  "#{document_user.legal_name}'s signature pending",
          id:       document_user.id,
          user_id:  user.id
        }
        
      else
        {
          status:   'error',
          message:  "#{document_user.role} is not assigned to a user",
          id:        document_user.id
        }
      end
    else
      {
        status: 'ok',
        id: document_user.id
      }
    end
  end
  
  
  
end

