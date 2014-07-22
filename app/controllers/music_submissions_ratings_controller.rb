class MusicSubmissionsRatingsController < ApplicationController
  def update
    
    @music_submission = MusicSubmission.find(params[:id])
    
    if @music_submission.update_attributes(stars: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end
  
  def show
    
  end
end
