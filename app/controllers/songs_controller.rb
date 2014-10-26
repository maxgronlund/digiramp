class SongsController < ApplicationController
  def index
    
    if params[:recording].nil?
      params[:recording] = {order: 'uniq_likes_count', direction: 'desc'}
    end
    
    #params[:recording] = {order: 'uniq_likes_count', direction: 'asc'}
    
    order = params[:recording][:order] + ' ' + params[:recording][:direction]
    
    ap params
    
    if params[:genre]
      genre = Genre.where(title: params[:genre]).first
      recordings = genre.ordered_recordings order
    else
      recordings = Recording.order(order)
    end
    @songs =  Recording.recordings_search(recordings, params[:query]).page(params[:page]).per(4)
    @playlists = current_user.playlists if current_user
    
    #@songs =  Recording.all.page(params[:page]).per(4)
    
  end
  
end
