class SongsController < ApplicationController
  def index
    ap params
    order = params[:recording][:order] + ' ' + params[:recording][:direction]
    if params[:genre]
      genre = Genre.where(title: params[:genre]).first
      recordings = genre.ordered_recordings order
    else
      recordings = Recording.order(order)
    end
    recordings.uniq!
    @songs =  Recording.recordings_search(recordings, params[:query]).page(params[:page]).per(4)
    #@songs =  Recording.recordings_search(Recording.all, params[:query]).page(params[:page]).per(4)
  end
  
end
