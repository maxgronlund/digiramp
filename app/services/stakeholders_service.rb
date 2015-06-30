class StakeholdersService
  
  
  def self.assign_to_recording recording_id, representative_id
    return 0 unless recording = Recording.cached_find(recording_id)
    return 1 unless user      = User.cached_find(representative_id) 
    
    
    digiramp_split       = 0.2
    representative_split = 0.2
    work_split           = 0.3
    recording_split      = 0.3
    

     
  end
  
  
  
  

  
  
end