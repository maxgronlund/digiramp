class User::IpisController < ApplicationController
  
  before_action :access_user
  
  def index
    #@user_credits = @user.user_credits.where.not(confirmation: 'Missing').order(:title)
    ap params
    @user_credits = @user.user_credits
  end
  
  def show
     ap params
    @ipi          = Ipi.cached_find(params[:id])
    not_found( params )  unless ( @common_work = @ipi.common_work ) && ( account = @common_work.account ) && ( @requester = account.user )
  end
  
  def new
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    @ipi          = Ipi.cached_find(params[:ipi])
    @ipi.title    = "Please confirm your rights on #{@common_work.title}"
    @ipi.message  = "Hi \nI would like you to confirm you share and rights on #{@common_work.title} as:\n#{@ipi.roles_as_string} \n\n--#{@user.user_name}"
    #render nothing: true
  end
  
  def update
    
    
    @ipi          = Ipi.cached_find(params[:id])
    @common_work = CommonWork.cached_find(@ipi.common_work_id)
    if @ipi.update(ipi_params)
      if params[:commit] == 'Send'
        @ipi.send_confirmation_request 
      else
        redirect_to user_user_ipi_path(@user, @ipi)
      end
    else
      render :edit
    end

  end
  
  

  
  def edit
     @ipi         = Ipi.cached_find(params[:id])
     @common_work = CommonWork.cached_find(@ipi.common_work_id)
  end
  

  
 
private

  def ipi_params
    params.require(:ipi).permit!
  end
  
  
end