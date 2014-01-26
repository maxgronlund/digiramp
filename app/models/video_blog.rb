class VideoBlog < ActiveRecord::Base
  has_many :videos
  #attr_accessible :title, :body


end
