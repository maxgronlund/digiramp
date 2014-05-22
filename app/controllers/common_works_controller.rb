class CommonWorksController < ApplicationController
  
  include AccountsHelper
  before_filter :access_to_account
  
  def show
    @common_work    = CommonWork.cached_find(params[:id])
    
    # pessimistic locking
    access = false
    
    if @common_work.is_accessible_by current_user
      access                                = true
      @user_can_access_shared_with          = true
      @user_can_access_files                = true
      @user_can_access_legal_documents      = true
      @user_can_access_financial_documents  = true
      @user_can_access_ipis                 = true
      @can_delete                           = true
      @can_edit                             = true
    elsif work_user = WorkUser.cached_where(@common_work.id, current_user.id)
      access                                = true
      @user_can_access_files                = work_user.access_files
      @user_can_access_legal_documents      = work_user.access_legal_documents
      @user_can_access_financial_documents  = work_user.access_financial_documents
      if @user_can_access_ipis              = work_user.access_ipis
        @show_more      = true
      end
    end
      
    if access 
      render :show
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
end
