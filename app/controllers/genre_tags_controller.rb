class GenreTagsController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  
  def index
    @recording            = Recording.cached_find(params[:recording_id])
    @common_work          = CommonWork.cached_find(params[:common_work_id])
    @added_genge_tags     = @recording.genre_tags.size
    @disable_more_genres  = @added_genge_tags > 3
  end
  
  def new
    @recording            = Recording.cached_find(params[:recording_id])
    @genre                = Genre.find(params[:genre_id])
    
    @genre_tag = GenreTag.where(genre_id: params[:genre_id], 
                                genre_tagable_type: @recording.class.to_s, 
                                genre_tagable_id: @recording.id)
                                .first_or_create(
                                  genre_id: params[:genre_id], 
                                  genre_tagable_type: @recording.class.to_s, 
                                  genre_tagable_id: @recording.id
                                )
                                
    
                                  
    update_recording
    redirect_to :back
  end
  
  def destroy
    @recording            = Recording.cached_find(params[:recording_id])
    @genre_tag = GenreTag.cached_find(params[:id])
    @genre_tag.destroy!
    update_recording
    redirect_to :back
  end
  
  def update_recording
    genre = ''
    @recording.genre_tags.each do |genre_tag|
      genre += genre_tag.genre.title
      genre += ' '
    end
    @recording.genre = genre
    @recording.save!
    @recording.get_common_work.update_completeness
  end
  
  
end
