class Admin::MoodsImportsController < ApplicationController
  #before_action :set_moods_import, only: [:show, :edit, :update, :destroy]
  before_action :admin_only

  def new
    @moods_import = MoodsImport.new
  end


  def create
    @moods_import = MoodsImport.new(moods_import_params)
    @moods_import.save!
    Mood.import_csv @moods_import.csv_file
    redirect_to admin_moods_path
  end


  private
    def set_moods_import
      @moods_import = MoodsImport.find(params[:id])
    end

    def moods_import_params
      params.require(:moods_import).permit(:csv_file)
    end
end
