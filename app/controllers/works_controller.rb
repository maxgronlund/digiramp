class WorksController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
    @blog          = Blog.works
    @manage_works  = BlogPost.where(identifier: 'Manage Works', blog_id: @blog.id).first_or_create(identifier: 'Manage Works', blog_id: @blog.id, title: 'Manage Works') 
    @common_works  = @account.common_works.order('title asc').page(params[:page]).per(32)
  end

  def show
    @common_work    = CommonWork.find(params[:id])
  end
  
  def edit
    @common_work    = CommonWork.find(params[:id])
  end
  
  def update
    @common_work    = CommonWork.find(params[:id])
    @account.works_cache_key += 1
    @account.save
    if @common_work.update_attributes(common_work_params)
      redirect_to account_work_path(@account, @common_work)
    else
      render :edit
    end
  end
  
  def destroy
    @common_work    = CommonWork.find(params[:id])
    @common_work.destroy
    @account.works_cache_key += 1
    @account.save
    redirect_to account_works_path @account

  end
  
private
  
  def common_work_params
    params.require(:common_work).permit!
  end
  
  
end
