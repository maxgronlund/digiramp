class Admin::ExportGenresController < ApplicationController
  before_filter :admin_only
  
  def index
    @genres = Genre.order(:category)
    respond_to do |format|
      format.html
      format.csv { render text: @genres.to_csv }
    end
  end
  
  
end
