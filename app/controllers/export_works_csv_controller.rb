class ExportWorksCsvController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  def index
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    export
  end
  
  def show
    @common_work  = CommonWork.cached_find(params[:id])
    export
  end
  
  private
  
  def export
    respond_to do |format|
      format.html
      format.csv { render text: @common_work.to_csv }
    end
  end
  

  
end
