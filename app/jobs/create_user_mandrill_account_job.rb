class CreateUserMandrillAccountJob < ActiveJob::Base
  queue_as :default

  def perform(user_id)
    begin
      user = User.cached_find(user_id)
      MandrillAccountService.create_account_for_user self
    rescue => e
      Opbeat.capture_message("Create Mandrill Subaccount #{e.inspect}")
    end
  end
end
