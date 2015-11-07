# Create or Destroy a user_notificatio
# include in model owned by a user
module NotificationModule
  
  def update_notification_message parrent, user_id
    ap 'NotificationModule#update_notification_message'
    ap user_id
    ap parrent.id
    ap parrent.class.name
    notification_message = NotificationMessage.where(
      user_id: user_id,
      asset_id: parrent.id,
      asset_type: parrent.class.name,
    )
    .first_or_create(
      user_id: user_id,
      asset_id: parrent.id,
      asset_type: parrent.class.name
    )

  end

  # remove the user notification
  def remove_notification_message parrent,  user_id
    ap 'NotificationModule#remove_notification_message'
    ap user_id
    ap parrent.id
    ap parrent.class.name
    if notification_message = NotificationMessage.find_by(
        user_id: user_id,
        asset_id: parrent.id,
        asset_type: parrent.class.name
      )
      notification_message.destroy
    end
  end
  
  # build a message has for the error message
  def message_hash parrent, msg
    {
      message:      msg,
      type:         parrent.class.name,
      id:           parrent.id
    }
  end
  
end