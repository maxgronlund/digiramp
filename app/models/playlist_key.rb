class PlaylistKey < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user
  
  has_many :customer_events
end
