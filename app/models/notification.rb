class Notification < ActiveRecord::Base
  belongs_to :account
  belongs_to :notification_event
  
  #attr_accessible :body, :image_url, :title, :time, :sticky, :notification_type, :notification_event_id, :account_id
  before_create :init_notification_event
  
  def init_notification_event
    self.notification_event_id = NotificationEvent.create.id unless self.notification_event_id
  end
  
  def to_hash
    {
      id: id,
      title: title,
      body: body,
      type: notification_type,   
      notification_event_id: notification_event_id,
      sticky: sticky,
      time: time
    }
  end
end