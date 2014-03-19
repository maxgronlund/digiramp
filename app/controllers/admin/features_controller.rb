class Admin::FeaturesController < ApplicationController
  before_filter :admins_only
  def edit
    @feature = Feature.front
  end

  def update
    @feature = Feature.front
    if @feature.update(feature_params)
      flash[:info] = { title: "SUCCESS: ", body: "Features page updated" }
    else
      flash[:danger] = { title: "Error", body: "Features page not updated" }
    end
    redirect_to edit_admin_feature_path(@feature)
    
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_params
      params.require(:feature).permit(:title, :body, :video1_id, :video2_id, :video3_id, :video4_id, :video5_id) if current_user.can_edit?
    end
end
