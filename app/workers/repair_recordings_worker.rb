class RepairRecordingsWorker
  include Sidekiq::Worker
  
  def perform( account_id )
    account = Account.cached_find(account_id)
    account.repair_recordings
  end
end