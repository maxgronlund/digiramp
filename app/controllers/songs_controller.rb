class SongsController < ApplicationController
  def index
    @songs =  Recording.recordings_search(Recording.all, params[:query]).page(params[:page]).per(4)
  end
end
