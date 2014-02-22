class SingleWorkController < ApplicationController
  before_filter :there_is_access_to_the_account
  before_filter :get_blog
  
  def show
    @common_work      = CommonWork.find(params[:id])
  end
  
  
  def new
    @new_single_work  = new_single_work
    @common_work      = CommonWork.new
  end
  
  def create
    @common_work = CommonWork.new(common_work_params)
    if @common_work.save
      redirect_to account_single_work_description_path(@account, @common_work)
      
    else
      render :new
    end

  end
  
  def edit
    @new_single_work  = new_single_work
    @common_work      = CommonWork.find(params[:single_work_id])
  end
  
  def update
    @common_work = CommonWork.find(params[:single_work_id])
    if @common_work.update_attributes(common_work_params)
      case @common_work.step
      when 'created'
        redirect_to account_single_work_lyrics_path(@account, @common_work)
      #when 'described'
      #  redirect_to account_single_work_recordings_path(@account, @common_work)
      when 'lyrics added'
        redirect_to account_single_work_recordings_path(@account, @common_work)
      when 'recordings added'
        redirect_to account_single_work_ipis_path(@account, @common_work)
      when 'ipis added'
        redirect_to account_single_work_users_path(@account, @common_work)
      when 'users added'
        redirect_to account_single_work_path(@account, @common_work)
      end
    end

  end
  
  
  def description
    @add_description = add_description
    @common_work      = CommonWork.find(params[:single_work_id])
  end
  
  def recordings
    @add_recording = add_recording
    @common_work    = CommonWork.find(params[:single_work_id])
  end
  
  def lyrics
    @add_lytics = add_recording
    @common_work    = CommonWork.find(params[:single_work_id])
  end
  
  def ipis
    @add_ipis       = add_ipis
    @common_work    = CommonWork.find(params[:single_work_id])
  end
  
  def users
    @add_users      = add_users
    @common_work    = CommonWork.find(params[:single_work_id])
  end
  
  
  private
  
  def common_work_params
    params.require(:common_work).permit!
  end
  
  def get_blog
    @blog  = Blog.add_content
  end
  
  def new_single_work
    BlogPost.where(identifier: 'New Single Work', blog_id: @blog.id)\
            .first_or_create(identifier: 'New Single Work', blog_id: @blog.id, title: 'New Single Work', body: 'Add one Common Work') 
  end
  
  def add_description
    BlogPost.where(identifier: 'Add Description', blog_id: @blog.id)\
            .first_or_create(identifier: 'Add Description', blog_id: @blog.id, title: 'Add Description', body: 'Improve the search') 
  end
  
  def add_lytics
    BlogPost.where(identifier: 'Add Lyrics', blog_id: @blog.id)\
            .first_or_create(identifier: 'Add Lyrics', blog_id: @blog.id, title: 'Add Lyrics', body: 'Improve the search') 
  end
  
  def add_recording
    BlogPost.where(identifier: 'Add Recording', blog_id: @blog.id)\
            .first_or_create(identifier: 'Add Recording', blog_id: @blog.id, title: 'Add Recording', body: 'Upload a recording so people can listen to your work') 
  end
  
  def add_ipis
    BlogPost.where(identifier: "Add Interested Parties Info", blog_id: @blog.id)\
            .first_or_create(identifier: 'Add Interested Parties Info', blog_id: @blog.id, title: 'Add Interested Parties Info', body: 'People with a interest in the work') 
  end
  
  def add_users
    BlogPost.where(identifier: "Add Users", blog_id: @blog.id)\
            .first_or_create(identifier: 'Add Users', blog_id: @blog.id, title: 'Add Users', body: 'People you want to have access to this work') 
  end
  
  
  
end
