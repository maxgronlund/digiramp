module OpportunitiesHelper
  
  def access_opportunity 
    not_found unless @opportunity         = Opportunity.cached_find(params[:id])
    not_found unless @user                = User.cached_find(params[:user_id])
    not_found unless @opportunity_user    = current_opportunity_user
    unless super?
      forbidden unless @opportunity_user = OpportunityUser.find_by( opportunity_id: @opportunity.id, user_id: @user.id)  
    end
    if current_user.nil?
      login_new_path
    end
  end
end
