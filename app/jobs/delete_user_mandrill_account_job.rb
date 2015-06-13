class DeleteUserMandrillAccountJob < ActiveJob::Base
  queue_as :default

  def perform(mandrill_account_id)

    begin
      mandril_client    = Mandrill::API.new Rails.application.secrets.email_provider_password
      mandril_client.subaccounts.delete mandrill_account_id
    rescue Mandrill::Error => e
      Opbeat.capture_message("A mandrill error occurred: #{e.class} - #{e.message}")
    end
  end
end


