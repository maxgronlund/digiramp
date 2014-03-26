class Playlist < ActiveRecord::Base
  belongs_to :account
  
  has_many :playlist_items
  has_many :playlist_keys
  #has_many :activity_events, as: :activity_eventable
  #has_many :invites,         as: :inviteable
  #has_many :permissions, as: :permissionable
  
  
end
