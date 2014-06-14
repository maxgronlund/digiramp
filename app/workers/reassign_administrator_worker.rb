class ReassignAdministratorWorker
  include Sidekiq::Worker
  
  def perform options={}
    
    account_id            = options[:account_id]
    old_administrator_id  = options[:old_administrator_id]

    begin
      account = Account.cached_find(account_id)
      account.reassign_administrator( old_administrator_id )
    rescue
      '------------------- here is ...----------------------'
    end
     
    
  end
end