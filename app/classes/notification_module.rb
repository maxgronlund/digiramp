# Create or Destroy a user_notificatio
# include in model owned by a user
module NotificationModule
  
  def update_notification_message user_id

    notification_message = NotificationMessage.where(
      user_id: user_id,
      asset_id: self.id,
      asset_type: self.class.name,
    )
    .first_or_create(
      user_id: user_id,
      asset_id: self.id,
      asset_type: self.class.name
    )

  end

  # remove the user notification
  def remove_notification_message user_id
    if notification_message = NotificationMessage.find_by(
        user_id: user_id,
        asset_id: self.id,
        asset_type: self.class.name
      )
      notification_message.destroy
    end
  end
end