class AddErrorMessageToUserNotifications < ActiveRecord::Migration
  def change
    add_column :user_notifications, :error_message, :text
  end
end
