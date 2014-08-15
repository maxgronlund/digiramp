class PlayerAlphasController < ApplicationController
  respond_to :html, :xml, :json
  
  def index
    ap params
    @recordings = Recording.find(352,351)
    #respond_to do |format|
    #  format.html 
    #  format.json { render json: @recordings }
    #end
    respond_with Recording.find(352,351)
  end
  
  def show
    @recording = Recording.find(params[:id])
    respond_to do |format|
      format.html 
      format.json { render json: @recording }
     end
    #respond_with Recording.find(params[:id])
  end
  
  def update
    respond_with Recording.update(params[:id], params[:recording])
  end
  
  
end
