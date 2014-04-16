class WorkUsersController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
    @common_work    = CommonWork.cached_find(params[:work_id])
  end
  # touch
    
  
  
  def new
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @work_user  = WorkUser.new
  end
  
  def create
    @common_work = CommonWork.cached_find(params[:common_work_id])
    if @user = get_persona
      params[:work_user][:user_id] = @user.id
      @work_user = WorkUser.create(work_user_params)
      redirect_to account_work_path(@account, @common_work)
    else
      redirect_to :back
    end
  end
  
  def edit
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @work_user   = WorkUser.cached_find(params[:id])
  end
  
  def update
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @work_user   = WorkUser.cached_find(params[:id])
    @work_user.update_attributes(work_user_params)
    redirect_to account_work_path(@account, @common_work)
  end
  
  def destroy
    @work_user = WorkUser.cached_find(params[:id])
    @work_user.destroy
    @common_work = CommonWork.cached_find(params[:common_work_id])
    redirect_to account_work_path(@account, @common_work)
  end
  
  def work_user_params
    params.require(:work_user).permit!
  end
  
  private
  
  def get_persona
    persona = User.where(email: params[:work_user][:email]).first
    unless persona
      flash[:danger] = { title: "User not a member", body: "Please ask the person you are about to invite to sign up for an account" }
      return nil
    end
    
    unless AccountUser.where(user_id: persona.id, account_id: @account.id).first
      flash[:danger] = { title: "User not an client", body: "Please add the user as an client to your account first" }
      return nil
    end
    
    if WorkUser.where(user_id: persona.id, common_work_id: @common_work.id).first
      flash[:danger] = { title: "User already added", body: "Please edit the persons permissions instead" }
      return nil
    end
     persona
  end
  
 

end
