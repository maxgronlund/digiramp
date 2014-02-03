class FeaturesController < ApplicationController
  def index
    @feature = Feature.front
    @video_blog = VideoBlog.features
    @video1     = @video_blog.videos.where(identifyer: 'feature1').first_or_create(identifyer: 'feature1', title: 'feature 1')
    @video2     = @video_blog.videos.where(identifyer: 'feature2').first_or_create(identifyer: 'feature2', title: 'feature 2')
    @video3     = @video_blog.videos.where(identifyer: 'feature3').first_or_create(identifyer: 'feature3', title: 'feature 3')
    @video4     = @video_blog.videos.where(identifyer: 'feature4').first_or_create(identifyer: 'feature4', title: 'feature 4')
    @video5     = @video_blog.videos.where(identifyer: 'feature5').first_or_create(identifyer: 'feature5', title: 'feature 5')
    #@video1   = Video.exists?(@feature.video1_id)
  end
end
