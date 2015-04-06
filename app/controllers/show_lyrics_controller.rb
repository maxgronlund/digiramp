class ShowLyricsController < ApplicationController
  def show

    if params[:work]
      common_work = CommonWork.cached_find(params[:id])
      @lyrics =  common_work.lyrics
      @id     = common_work.id
    end
  end
end
