class SongsController < ApplicationController
  
  def index
    
    if params[:recording].nil?
      params[:recording] = {order: 'uniq_likes_count', direction: 'desc'}
    end

    order = params[:recording][:order] + ' ' + params[:recording][:direction]
    

    
    if params[:genre]
      genre = Genre.where(title: params[:genre]).first
      recordings = genre.ordered_recordings_with_public_access order
    else
      recordings = Recording.public_access.order(order)
    end
    
    @songs      =  Recording.recordings_search(recordings, params[:query]).page(params[:page]).per(4)
    @playlists  =  current_user.playlists if current_user
    
    
    
  end
  
  def show
    #puts '-------------------------------- alert ------------------------------------------'
    # this shoule never been calle dbut it is
    render nothing: true
  end
  
  
  
end
