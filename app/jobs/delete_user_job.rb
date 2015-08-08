class DeleteUserJob < ActiveJob::Base
  queue_as :default

  # add a default avatar to the user
  def perform user_id

    if user      = User.cached_find(user_id.to_i)
      user.create_activity(  :destroyed, 
                         owner: user,
                     recipient: user,
                recipient_type: user.class.name,
                    account_id: user.account.id)
      
      user.account.destroy!  
      user.destroy
    else
      ErrorNotification.post "Unable to delete user: #{user_id}"
    end
      
    end
end

