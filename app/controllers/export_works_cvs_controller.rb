class ExportWorksCvsController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
    
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    respond_to do |format|
      format.html
      format.csv { render text: @common_works.to_csv }
    end
  end
  
  
end
