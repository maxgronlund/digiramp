class Digiwham::RecordingsController < ApplicationController
  

  def index
    @recordings = Recording.find(352,351,350,490)
  end
  
  
end
