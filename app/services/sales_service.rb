# This class validates a recording by iterating true all the associated data. 
# ==== Example
#  sales_service = SalesService.new(RECORDING_ID)
#  sales_service.validate
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
      @error_message = nil
    else
      @error_message = {
        status: 'error',
        message: 'Recording not found'
      }
    end
  end
  
  # Entry point for a validation cycle
  #
  # * Is there a common work
  # * Is is the commen_work 100% cleared
  # * is the recording 100% cleared
  def validate
    return @error_message if @error_message
    
    {
      status: 'ok',
      common_work: validate_existence_of_work,
      recording: validate_recording
    }
  end
  
  
  
  # Check if the is 100% cleared
  def validate_recording
    if recording_ipis = @recording.recording_ipis
      validated_recording_ipis = []
      recording_ipis.each do |recording_ipi|
        validated_recording_ipi = validate_recording_ipi recording_ipi
        
        validated_recording_ipis << validated_recording_ipi
        
      end
      
      {
        status: 'ok',
        id:               @recording.id,
        titel:            @recording.title,
        recording_ipis:   validated_recording_ipis
        
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
  
  
  
  
  # Check if the work exists
  def validate_existence_of_work
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
        id:     document.id
      }
    else
      {
       status: 'error',
       message: 'Document not signed',
       title:  document.title,
       id:     document.id 
      }
    end
    
  end
  
  
  
  
end

