class RecordingWidgetsController < ApplicationController
  def show
    
    begin 
      @recording = Recording.cached_find(params[:id])
      return nil unless @recording.privacy == 'Anyone'
    rescue
      
    end
  end
end
