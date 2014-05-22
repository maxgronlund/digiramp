class ExportWorksCsvController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  
  def index
    
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    respond_to do |format|
      format.html
      format.csv { render text: @common_works.to_csv }
    end
  end
  
  def show
    @common_work  = CommonWork.cached_find(params[:id])
    respond_to do |format|
      format.html
      format.csv { render text: @common_work.to_csv }
    end
  end
  
  
end
