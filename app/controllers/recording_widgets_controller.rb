class RecordingWidgetsController < ApplicationController
  def show
    
    begin 
      @recording = Recording.cached_find(params[:id])
      return nil unless @recording.public_access
    rescue
    end
  end
end
