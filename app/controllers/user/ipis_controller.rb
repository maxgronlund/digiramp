class User::IpisController < ApplicationController
  
  before_action :access_user
  
  def index
    #@user_credits = @user.user_credits.where.not(confirmation: 'Missing').order(:title)
    logger.info params
    logger.info @user
    @user_credits = @user.user_credits
  end
  
  def show
     
    @ipi          = Ipi.cached_find(params[:id])
    not_found( params )  unless ( @common_work = @ipi.common_work ) && ( account = @common_work.account ) && ( @requester = account.user )
  end
  
  def new
    @ipi          = Ipi.new
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    
    @ipi.title    = "Please confirm your rights on #{@common_work.title}"
    @ipi.message  = "Hi \nI would like you to confirm you share and rights on #{@common_work.title} as:\n#{@ipi.roles_as_string} \n\n--#{@user.user_name}"
    #render nothing: true
  end
  
  def create
    
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @ipi = Ipi.new(ipi_params)
    
    respond_to do |format|
      if @ipi.save
        
        format.html { 
          if params[:commit] == "Save and add next"
            redirect_to new_user_user_common_work_ipi_path(@user, @common_work) 
          else
            redirect_to user_user_common_work_path(@user, @common_work) 
          end
        }
        format.json { render :show, status: :created, location: @ipi }
      else
        format.html { render :new }
        format.json { render json: @ipi.errors, status: :unprocessable_entity }
      end
    end
  end
    
  
  
  def edit
     @ipi         = Ipi.cached_find(params[:id])
     @common_work = CommonWork.cached_find(@ipi.common_work_id)
  end
  
  def update
    @ipi          = Ipi.cached_find(params[:id])
    @common_work = CommonWork.cached_find(@ipi.common_work_id)
    
    if @ipi.update(ipi_params)
      if params[:commit] == 'Save and send message'
        @ipi.send_confirmation_request 
        redirect_to new_user_user_common_work_ipi_path(@user, @common_work)
      elsif params[:commit] == "Update"
        redirect_to session[:go_to_after_update_ipi]
      elsif params[:commit] == "Save"
        redirect_to new_user_user_common_work_ipi_path(@user, @common_work)
      end
      
        #if params[:commit] == 'Update'
        #  redirect_to session[:go_to_after_update_ipi]
        #  #redirect_to user_user_common_work_path(@user, @common_work)
        #else
        #  redirect_to user_user_ipi_path(@user, @ipi)
        #end
        #end
    else
      render :edit
    end
  end
  
  def destroy
    @ipi         = Ipi.cached_find(params[:id])
    @ipi.destroy
    @common_work = CommonWork.cached_find(@ipi.common_work_id)
    redirect_to user_user_common_work_path(@user, @common_work)
  end

 
private

  def ipi_params
    params.require(:ipi).permit!
  end
  
  
end