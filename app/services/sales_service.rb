#SalesService.validate_recording

class SalesService
  
  #def initialize recording_id
  #  #@recording = Recording.cached_find(recording_id)
  #  #validate_common_work
  #  true
  #end
  
  def self.validate_recording recording_id
    recording = Recording.cached_find(recording_id)
    status = 'ok'
    common_work = validate_common_work( recording )
    
    if common_work[:status] == 'error'
      status = 'error'
    end
    
    { status: status,
      common_work: 
      {
        status: common_work[:status], 
        title: common_work[:title],
        message: common_work[:message], 
        ipis: common_work[:ipis]
      }
    
    }
    
  end
  
  
  
  
  
  def self.validate_common_work recording

    if common_work = recording.common_work
      if common_work_ipis = common_work.common_work_ipis
        validated_common_work_ipis = validate_common_work_ipis( common_work_ipis )
        
        { 
          status: validated_common_work_ipis[:status], 
          title: common_work.title,
          message: validated_common_work_ipis[:message], 
          ipis:  validated_common_work_ipis[:ipis]
        }
      
      else
        { status: 'error', message: "No creators registered for #{common_wotk.title}"}
      end
      
    else
      { status: 'error', message: "Work is missing for #{recording.title}"}
    end
  end
  
  def self.validate_common_work_ipis common_work_ipis
    
    ipis = []
    status = 'ok'
    message = []
    common_work_ipis.each do |common_work_ipi|
      
      validated_ipi = validate_ipi( common_work_ipi) 
      ipis << validated_ipi
      if validated_ipi[:status] == 'error'
        status = 'error'
        message  << validated_ipi[:message]
      end
    end
    {
      status: status, 
      message: message, 
      ipis: ipis
    }
    #if common_work_ipis = common_work.common_work_ipis
    #  
    #  data = []
    #  {status: 'ok', message: nil, data: {status: 'ok', message: 'p', data: nil}}
    #  #common_work_ipis.each do |common_work_ipi|
    #  #  #ip = validate_ipi(common_work_ipi)
    #  #  data << {status: 'ok', message: nil, data: 'fobar'}
    #  #  #{status: ip[:status], message: ip[:message], data: ip[:data]}
    #  #end
    #else
    #  {status: 'error', message: 'No creators registered', data: nil}
    #end
    
  end
  #
  #
  def self.validate_ipi common_work_ipi
    
    if ipi = common_work_ipi.ipi
      {
        status: 'ok', 
        message: nil, 
        email:   common_work_ipi.email
      }
    else
      if common_work_ipi.email.nil?
        message = "Email for creator is missing"
      else
        message = "Ip not assigned for creator with email #{common_work_ipi.email}"
      end
      { 
        status: 'error',
        message: message,
        email:   common_work_ipi.email
      }
    end
  end
  
  
end



# 

# {:error, 'some string'}