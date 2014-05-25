class AccountWorker
  include Sidekiq::Worker
  
  def perform( account_user_id )
    puts 'Doing hard work'
    # fetch the account_user
    account_user = AccountUser.cached_find(account_user_id)
    
    # fetch the account
    account    = account_user.account
    
    # update the white list for the account
    AccountPermissions.update_user( account_user, account )
    
    # update permissions for all recordings
    RecordingPermissions.update_accound_users_permissions account_user
    
  end
  

end