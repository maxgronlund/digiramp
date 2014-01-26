class ActivityEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_log
  belongs_to :activity_eventable, polymorphic: true
  
  after_create :delete_if_duplicate
  
  def delete_if_duplicate
    activities = find_activities
    
    new_activity = activities[0]
    prev_activity = activities[1]

    if (new_activity   and prev_activity)                                              and
       (new_activity.r and prev_activity.r)                                            and
       (new_activity.created_at - prev_activity.created_at) < 5.minutes                and
       (new_activity.activity_eventable_id   == prev_activity.activity_eventable_id)   and
       (new_activity.activity_eventable_type == prev_activity.activity_eventable_type)
       
      new_activity.delete
    end
  end
  
  def find_activities
    if user
      activity_log.activity_events
      .where(user_id: user.id).order("id desc").first(2)
      #.find(:all, :order => "id desc", :limit => 2)
    else
      activity_log.activity_events
      .where('user_id IS NULL').order("id desc").first(2)
      #.find(:all, :order => "id desc", :limit => 2)
    end
  end
end
