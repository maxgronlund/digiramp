class Admin::InstrumentsImportsController < ApplicationController
  #before_action :set_instruments_import, only: [:show, :edit, :update, :destroy]
  before_filter :admin_only

  def new
    @instruments_import = InstrumentsImport.new
  end


  def create
    @instruments_import = InstrumentsImport.new(instruments_import_params)
    @instruments_import.save!
    Instrument.import_csv @instruments_import.csv_file
    redirect_to admin_instruments_path
  end


  private
    def set_instruments_import
      @instruments_import = InstrumentsImport.find(params[:id])
    end

    def instruments_import_params
      params.require(:instruments_import).permit(:csv_file)
    end
end
