class SingleWorkController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  before_filter :access_account
  #before_filter :get_blog
  
  def show
    @common_work      = CommonWork.find(params[:id])
    redirect_to account_work_path( @account, @common_work)
  end
  
  
  def new
    #@new_single_work  = new_single_work
    @common_work      = CommonWork.new
  end
  
  def create
    @common_work = CommonWork.new(common_work_params)
    if @common_work.save
      redirect_to account_single_work_lyrics_path(@account, @common_work)
    else
      render :new
    end
  end
  
  def edit
    #@new_single_work  = new_single_work
    @common_work      = CommonWork.find(params[:single_work_id])
  end
  
  def update
    @common_work = CommonWork.find(params[:single_work_id])
   
    @account.save
    if @common_work.update_attributes(common_work_params)
      case @common_work.step
      when 'created'
        redirect_to account_single_work_lyrics_path(@account, @common_work)
      when 'lyrics added'
        redirect_to account_single_work_recordings_path(@account, @common_work)
      when 'recordings added'
        redirect_to account_single_work_path(@account, @common_work)
        #redirect_to account_single_work_ipis_path(@account, @common_work)
        #when 'ipis added'
        #  redirect_to account_single_work_users_path(@account, @common_work)
        #when 'users added'
        #  redirect_to account_single_work_path(@account, @common_work)
      end
    end

  end
  
  def create_recording

    @common_work          = CommonWork.find(params[:single_work_id])
    TransloaditParser.add_to_common_work( params[:transloadit], @common_work.id, @account.id )
    
    flash[:info]          = { title: "SUCCESS: ", body: "Common Work Created" }
    redirect_to account_single_work_path(@account, @common_work)
    #redirect_to account_single_work_ipis_path(@account, @common_work)
  end
  
  
  #def description
  #  @add_description = add_description
  #  @common_work      = CommonWork.find(params[:single_work_id])
  #end
  
  def recordings
    @recording      = Recording.new
    @common_work    = CommonWork.find(params[:single_work_id])
  end
  
  def lyrics
    @common_work    = CommonWork.find(params[:single_work_id])
  end
  
  def ipis
    @common_work    = CommonWork.find(params[:single_work_id])
  end
  #
  def users
    @common_work    = CommonWork.find(params[:single_work_id])
  end
  
  
  private
  
  def common_work_params
    params.require(:common_work).permit!
  end

  
  
  
end
