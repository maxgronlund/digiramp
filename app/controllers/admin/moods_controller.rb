class Admin::MoodsController < ApplicationController
  before_filter :admin_only

  def index
    @moods = Mood.search(params[:query]).order('lower(title) ASC').page(params[:page]).per(32)
  end
  
  def new
    @mood = Mood.new
  end
  
  def create
    if @mood = Mood.create(mood_params)
      flash[:success]   = { title: 'Success', body: 'Mood created' }
      redirect_to_return_url admin_moods_path
    else
      redirect_to :back
    end
    
  end

  def edit
    @mood = Mood.cached_find(params[:id])
    
  end
  
  def update
    
    @mood = Mood.find(params[:id])
    if @mood.update_attributes(mood_params)
      flash[:success]   = { title: 'Success', body: 'Mood updated' }
      redirect_to admin_moods_path
    else
      redirect_to :back
    end
    
  end
  
  def destroy
    @mood = Mood.find(params[:id])
    @mood.destroy!
    flash[:success]   = { title: 'Success', body: 'Mood deleted' }
    redirect_to_return_url admin_moods_path
  end
private
  def mood_params
    params.require(:mood).permit! if current_user.can_edit?
  end
end
