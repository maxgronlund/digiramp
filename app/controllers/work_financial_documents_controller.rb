class WorkFinancialDocumentsController < ApplicationController
  before_filter :there_is_access_to_the_account

  def index
    @common_work    = CommonWork.cached_find(params[:work_id])
    if @common_work.financial_documents_is_accessible_by current_user
      render :index
    else
      @common_work = nil
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end

end
