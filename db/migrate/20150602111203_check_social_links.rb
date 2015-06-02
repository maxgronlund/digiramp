class CheckSocialLinks < ActiveRecord::Migration

  
  def change
    broken_users = []
    super_broken_users = []
    User.find_each do |user|
      begin
        user.save!
      rescue
        broken_users << {  id: user.id,
                           email: user.email, 
                           link_to_tumblr:      user.link_to_tumblr,
                           link_to_instagram:   user.link_to_instagram,
                           link_to_youtube:     user.link_to_youtube,
                           link_to_facebook:    user.link_to_facebook,
                           link_to_twitter:     user.link_to_twitter,
                           link_to_linkedin:    user.link_to_linkedin,
                           link_to_google_plus: user.link_to_google_plus
                         }
        #ap user.email
      end
    end
    
    ap '=========== Broken ====================='
    ap broken_users.count
    ap '================================'
    
    broken_users.each do |broken_user|
      
      
      user = User.find( broken_user[:id])
      

      unless match_email( user.email )
        ap user.email + ": is broken beyound repair"
        super_broken_users << broken_user
      else
        unless match_url( user.link_to_tumblr )
          user.link_to_tumblr = ""
        end
        
        unless match_url( user.link_to_instagram )
          user.link_to_instagram = ""
        end
        
        unless match_url( user.link_to_youtube )
          user.link_to_youtube = ""
        end
        
        unless match_url( user.link_to_facebook )
          user.link_to_facebook = ""
        end
        
        unless match_url( user.link_to_twitter )
          user.link_to_twitter = ""
        end
        
        unless match_url( user.link_to_linkedin )
          user.link_to_linkedin = ""
        end
        
        unless match_url( user.link_to_google_plus )
          user.link_to_google_plus = ""
        end
        

        
        unless match_url( user.link_to_homepage )
          user.link_to_homepage = ""
        end
        
        user.save!
          
     
        
        #ap user
      end
      
    end
    ap '============ super broken===================='
    ap super_broken_users.count
    ap super_broken_users
    ap '================================'
  end
  
  def match_email email
    /\A([^@\s]+)@((?:(?!-)[-a-z0-9]+(?<!-)\.)+[a-z]{2,})\z/.match(email)
  end
  
  def match_url url
    /\Ahttps?:\/\/([^\s:@]+:[^\s:@]*@)?[A-Za-z\d\-]+(\.[A-Za-z\d\-]+)+\.?(:\d{1,5})?([\/?]\S*)?\z/.match(url)
  end
end
