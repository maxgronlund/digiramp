class CreateUserMandrillAccountJob < ActiveJob::Base
  queue_as :default

  def perform(user_id)
    begin
      MandrillAccountService.create_account_for_user user_id
    rescue => e
      Opbeat.capture_message("Create Mandrill Subaccount #{e.inspect}")
    end
  end
end
