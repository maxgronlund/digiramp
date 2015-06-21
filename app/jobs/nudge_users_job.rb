class NudgeUsersJob < ActiveJob::Base
  queue_as :default

  def perform()
    #error = false
    ActiveRecord::Base.connection_pool.with_connection do
      ap 'Say hello from sidekiq'
    end
  end
end
