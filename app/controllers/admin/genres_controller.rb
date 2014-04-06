class Admin::GenresController < ApplicationController
  before_filter :admin_only
  def index
    @genres = Genre.search(params[:query]).order('lower(title) ASC').page(params[:page]).per(32)
    #redirect_to admin_genres_path( query: )
  end
  
  def new
    @genre = Genre.new
  end
  
  def create
    
    
    if @genre = Genre.create(genre_params)
      flash[:success]   = { title: 'Success', body: 'Genre created' }
      redirect_to_return_url admin_genres_path
    else
      redirect_to :back
    end
    
  end

  def edit
    @genre = Genre.find(params[:id])
    #@categories = []
    #
    #Genre::GENRE_CATEGORY.each do |genre_category|
    #  @categories << genre_category[0]
    #end
  end
  
  def update
    
    @genre = Genre.find(params[:id])
    if @genre.update_attributes(genre_params)
      flash[:success]   = { title: 'Success', body: 'Genre updated' }
      redirect_to_return_url admin_genres_path
    else
      redirect_to :back
    end
    
  end
  
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy!
    flash[:success]   = { title: 'Success', body: 'Genre deleted' }
    redirect_to_return_url admin_genres_path
  end
private
  def genre_params
    params.require(:genre).permit! if current_user.can_edit?
  end
end
