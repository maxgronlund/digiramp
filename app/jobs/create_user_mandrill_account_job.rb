class CreateUserMandrillAccountJob < ActiveJob::Base
  queue_as :default

  def perform(user_id)
    begin
      MandrillAccountService.create_account_for_user( user_id )
    rescue => e
      message = "Error create Mandrill subaccount for #{user_id} #{e.inspect}"
      ErrorNotification.post message
    end
  end
end


# CreateUserMandrillAccountJob.perform_later(User.last)