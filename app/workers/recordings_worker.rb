class RecordingsWorker
  include Sidekiq::Worker
  
  def perform( account_user_id )

    # fetch the account_user
    account_user = AccountUser.cached_find( account_user_id )

    # update permissions for all recordings
    RecordingPermissions.update_accound_user_permissions account_user
    
  end
  

end