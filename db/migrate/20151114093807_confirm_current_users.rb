class ConfirmCurrentUsers < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.update_columns(
        confirmation_sent_at: Time.now - 1.hour,
        confirmed_at: Time.now,
        confirmation_token: UUIDTools::UUID.timestamp_create().to_s
      )
    end
  end
end
