class ShareOnFacebooksController < ApplicationController
  before_action :set_share_on_facebook, only: [:show, :edit, :update, :destroy]

  # GET /share_on_facebooks
  # GET /share_on_facebooks.json
  
  def create
    ap params
    @recording  = Recording.cached_find(params[:share_on_facebook][:recording_id])
    @user       = User.cached_find(params[:share_on_facebook][:user_id])
    
    @share_on_facebook = ShareOnFacebook.new(share_on_facebook_params)
    if @share_on_facebook.save
      
      FbRecordingCommentWorker.perform_async(@share_on_facebook.id)
    end
    
    
    
    
    #@share_on_facebook = ShareOnFacebook.new(share_on_facebook_params)
    #
    #respond_to do |format|
    #  if @share_on_facebook.save
    #    format.html { redirect_to @share_on_facebook, notice: 'Share on facebook was successfully created.' }
    #    format.json { render :show, status: :created, location: @share_on_facebook }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @share_on_facebook.errors, status: :unprocessable_entity }
    #  end
    #end
  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_on_facebook
      @share_on_facebook = ShareOnFacebook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_on_facebook_params
      params.require(:share_on_facebook).permit(:user_id, :recording_id, :message)
    end
end
