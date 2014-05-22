class ExportWorksController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  
  def index
    
  end
  
  #def index
  #  @works = @account.common_works.order(:title)
  #  respond_to do |format|
  #    format.csv { render text: @works.to_csv }
  #  end
  #end

end
