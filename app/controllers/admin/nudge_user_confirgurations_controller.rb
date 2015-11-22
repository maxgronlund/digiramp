class Admin::NudgeUserConfirgurationsController < ApplicationController
  def new
    UserConfiguration.where( configured: [nil, false]).each do |user_configuration|
      if user = user_configuration.user
        
        if ( user_configuration.created_at < Time.now - 24.hours) && 
           ( user_configuration.say_what_you_want_email_count < 3 )
          
          user_configuration.update_columns(
            say_what_you_want_email_count: user_configuration.say_what_you_want_email_count += 1
          )
          UserMailer.delay.say_what_you_want user.id 
        end
      end
    end
    redirect_to admin_email_groups_path
  end
  

  
  
end
