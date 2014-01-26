class Song < ActiveRecord::Base
  belongs_to :account
  has_one   :recording
  has_one   :video
  has_one   :artwork
  has_many  :comments,        as: :commentable
  has_many  :activity_events, as: :activity_eventable
  has_many  :invites,         as: :inviteable
  has_many  :playlist_items,  as: :playlist_itemable
end
