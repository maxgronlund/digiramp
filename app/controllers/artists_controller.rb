class ArtistsController < ApplicationController

  def edit
    @user                 = User.friendly.find(params[:user_id])
    @recording            = Recording.cached_find(params[:id])
  end
  
  def update
    @recording            = Recording.cached_find(params[:id])
    @recording.performer  = params[:recording][:performer]
    @recording.artist     = params[:recording][:artist]
    @recording.composer   = params[:recording][:composer]
    @recording.band       = params[:recording][:band]
    @recording.save
    @user             = User.friendly.find(params[:user_id])
    @authorized       = true

  end
  

end
