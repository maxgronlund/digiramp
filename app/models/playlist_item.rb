class PlaylistItem < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :playlist_itemable, polymorphic: true
  #has_many :activity_events, as: :activity_eventable
  #has_many :comments, as: :commentable
  #serialize :crop_params, Hash
  #mount_uploader :image, PosterUploader
  #include ImageCrop
  #
  ## #attr_accessible :title, :body
  #
  #def media_file
  #  file = nil
  #  case self.playlist_itemable_type
  #  when 'Recording'
  #    file = Recording.find(self.playlist_itemable_id)
  #  when 'Video'
  #    file = Video.find(self.playlist_itemable_id)
  #  end
  #end
end
