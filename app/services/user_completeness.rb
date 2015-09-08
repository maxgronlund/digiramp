# UserCompleteness.process

class UserCompleteness
  
  def self.process user
    nr_required_params      = 0.0
    completeness            = 0.0
    
    #unless user.user_name
    #  begin
    #    default_name            = User.create_uniq_user_name_from_email(user.email)
    #    completeness            += 1 unless user.user_name            == default_name
    #    nr_required_params      += 1    
    #  rescue
    #  end      
    #end                                                   
                 
                                                                  
    completeness            += 1 unless user.profile.to_s         == ''
    nr_required_params      += 1 
                                                                                      
    completeness            += 1 unless user.profession.to_s      == ''
    nr_required_params      += 1                                  
                                                                  
    completeness            += 1 unless user.profession.to_s      == ''
    nr_required_params      += 1                                  
                                                                  
    completeness            += 1 unless user.country.to_s         == ''
    nr_required_params      += 1                                  
                                                                  
    completeness            += 1 unless user.city.to_s            == ''
    nr_required_params      += 1    
                            
    completeness            += 1 unless user.image_url.include?('5GA3Zk1C_avatar_')
    nr_required_params      += 1    
      
    user.completeness       = (completeness / nr_required_params * 100).to_i
    user.uniq_completeness  = user.completeness.to_uniq

    #artist        
    #author
    #composer
    #writer
    #
    #musician
    #producer
    #remixer
    #dj
    
  end
  
  
  
end