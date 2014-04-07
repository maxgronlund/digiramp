class Admin::ExportMoodsController < ApplicationController
  before_filter :admin_only
  
  def index
    @moods = Mood.order(category: :asc, title: :asc)
    respond_to do |format|
      format.html
      format.csv { render text: @moods.to_csv }
    end
  end
  
  
end
