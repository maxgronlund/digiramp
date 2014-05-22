class WorkLegalDocumentsController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  
  def index
    @common_work    = CommonWork.cached_find(params[:work_id])
    if @common_work.legal_documents_is_accessible_by current_user
      render :index
    else
      @common_work = nil
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
end
