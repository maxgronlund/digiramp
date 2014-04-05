class Admin::GenreImportsController < ApplicationController
  before_action :set_genre_import, only: [:show, :edit, :update, :destroy]
  before_filter :admin_only

  def new
    @genre_import = GenreImport.new
  end


  def create
    @genre_import = GenreImport.new(genre_import_params)
    @genre_import.save
    Genre.import_csv @genre_import.csv_file
    redirect_to admin_genres_path
  end



  private
    def set_genre_import
      @genre_import = GenreImport.find(params[:id])
    end

    def genre_import_params
      params.require(:genre_import).permit(:csv_file)
    end
end
