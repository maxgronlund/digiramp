class Digiwham::RecordingsController < ApplicationController
  

  def index
    puts '----------------------------------------- GOT THIS'
    ap params[:key]
    widget = Widget.where(secret_key: params[:key]).first
    @recordings = widget.catalog.recordings
    #@recordings = Recording.find(352,351,350,490)
  end
  
  # count playbacks
  def show
    puts '----------------------------------------- COUNT UP'
    render nothing: true
  end

end
