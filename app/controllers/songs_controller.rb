class SongsController < ApplicationController
  
  def index
    
    if params[:commit] == 'Go'
      params[:commit] = ''
      @remove_old_recordings = true
      session[:query] = params[:query]
    end
    
    session[:query] = nil if params[:clear] == 'clear'
    params[:query]  = session[:query]
    
    if params[:recording].nil?
      params[:recording] = {order: 'created_at', direction: 'desc'}
      #params[:recording][:featured] = true
    end
    
    if params[:query]
      order = ''
    else
      order = params[:recording][:order] + ' ' + params[:recording][:direction] 
    end  
    

    
    
    
    if params[:genre]
      if genre = Genre.where(title: params[:genre]).first
        recordings = genre.ordered_recordings_with_public_access order
      else
        recordings = Recording.public_access.order(order)
      end
    elsif params[:recording][:featured]
      ap '================================ FEATURED =============================='
      recordings = Recording.public_access.where(featured: true)
    else
      recordings = Recording.public_access.order(order)
    end
    
    
    
    @songs      =  Recording.recordings_search(recordings, params[:query]).page(params[:page]).per(4)
    @playlists  =  current_user.playlists if current_user
    
    
    
  end
  
  def show
    #puts '-------------------------------- alert ------------------------------------------'
    # this shoule never been calle dbut it is
    not_found params
  end
  
  
  
end
