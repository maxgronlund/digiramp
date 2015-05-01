class Admin::ExportGenresController < ApplicationController
  before_action :admin_only
  
  def index
    @genres = Genre.order(category: :asc, title: :asc)
    respond_to do |format|
      format.html
      format.csv { render text: @genres.to_csv }
    end
  end
  
  
end
