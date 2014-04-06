class Admin::ExportInstrumentsController < ApplicationController
  before_filter :admin_only
  
  def index
    @instruments = Instrument.order(category: :asc, title: :asc)
    respond_to do |format|
      format.html
      format.csv { render text: @instruments.to_csv }
    end
  end
  
  
end
