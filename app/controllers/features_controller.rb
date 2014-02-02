class FeaturesController < ApplicationController
  def index
    @feature = Feature.front
    @video_blog = VideoBlog.features
    @video1     = @video_blog.videos.where(title: 'upload').first_or_create(title: 'upload')
    #@video1   = Video.exists?(@feature.video1_id)
  end
end
