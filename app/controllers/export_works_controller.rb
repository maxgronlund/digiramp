class ExportWorksController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
    
  end
  
  #def index
  #  @works = @account.common_works.order(:title)
  #  respond_to do |format|
  #    format.csv { render text: @works.to_csv }
  #  end
  #end

end
