class SalesService
  
  #def initialize recording_id
  #  #@recording = Recording.cached_find(recording_id)
  #  #validate_common_work
  #  true
  #end
  
  def self.update_recording recording_id
    if recording = Recording.cached_find(recording_id)
      return {status: validate_common_work( recording )}
    else
      return {error: 'recording not found'}
    end
    
    
  end
  
  
  def self.validate_common_work recording
    if common_work = recording.common_work
      return false if common_work.common_work_ipis.count == 0
      
      common_work.common_work_ipis.each do |common_work_ipi|
        if ipi = common_work_ipi.ipi
          unless user = ipi.user
    
            return  'ipi not found'
          end
          
        else
          return 'ipi not found'
        end
      end
      return 'OK'
    end

  end
  
  
end



# SalesService.update_recording(2589)