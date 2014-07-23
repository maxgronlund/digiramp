class MusicSubmissionsRatingsController < ApplicationController
  def update
    
    @music_submission = MusicSubmission.find(params[:id])

    if @music_submission.update_attributes(stars: params[:score].to_s == '' ? 0 : params[:score])
      respond_to do |format|
        format.js
      end
    end
  end
  
  def show
    
  end
end
