class FixSpellErrorOnFollowerevents < ActiveRecord::Migration
  def change
    FollowerEvent.where(body: 'Listen to this recording').update_all(body: 'Listened to this recording')
  end
end
