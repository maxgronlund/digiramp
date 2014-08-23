class DigiWhamResourcesController < ApplicationController
  respond_to :json
  
  def index
    #ap params
    #@recordings = Recording.find(352,351,350,490)
  end
  
  def show
    #@recording = Recording.find(params[:id])
    #respond_to do |format|
    #  format.html 
    #  format.json { render json: @recording }
    # end
    respond_with Recording.find(params[:id])
  end
  
  def update
    respond_with Recording.update(params[:id], params[:recording])
  end
  
  
end
