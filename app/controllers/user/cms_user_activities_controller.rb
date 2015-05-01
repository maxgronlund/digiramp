class User::CmsUserActivitiesController < ApplicationController
  before_action :set_cms_user_activity, only: [:show, :edit, :update, :destroy]
  before_action :access_user


  def edit
  end

  
  def update
    respond_to do |format|
      if @cms_user_activity.update(cms_user_activity_params)
        format.html { redirect_to @cms_user_activity, notice: 'Cms user activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @cms_user_activity }
      else
        format.html { render :edit }
        format.json { render json: @cms_user_activity.errors, status: :unprocessable_entity }
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_user_activity
      @cms_user_activity = CmsUserActivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_user_activity_params
      params.require(:cms_user_activity).permit(:user_id)
    end
end
