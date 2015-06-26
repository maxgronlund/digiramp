class Admin::UsersController < ApplicationController
  
  #include UsersHelper
  before_action :admin_only
  
  before_action :set_user, only: [:show, :update, :destroy]
  
  
    
    

  def index
    @users = User.search(params[:query]).order('lower(email) ASC').page(params[:page]).per(50)
  end

  def show
    
  end
  
  def edit
    @edit_user =  User.friendly.find(params[:id])
  end
  
  def update

    
    if params[:user][:featured] == '1' && @user.featured == false
      # only update featured date when featured is turned on
      params[:user][:featured_date] = DateTime.now
    end
    
    old_role  = @user.role
    
    if @user.update!(user_params)
   
      
      @user.create_activity(  :updated, 
                         owner: current_user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account.id)
      
      
      
      
      
    else
      
      render :edit
    end

    redirect_to admin_users_path
  end
  
  
  def destroy
    begin
      @user     = User.cached_find(params[:id])
      @account  = @user.account
      @user.create_activity(  :destroyed, 
                         owner: current_user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account.id)
      
      @user_id = @user.id
      @user.destroy!
      

      #@account.create_activity(  :destroyed, 
      #                   owner: current_user,
      #               recipient: @account,
      #          recipient_type: @account.class.name,
      #              account_id: @account.account_id)
      #              
      #@account.destroy!

      
    rescue
      flash[:danger] = "Something went wrong" 
      puts '===============================   ERROR ==================================='
    end
    #redirect_to admin_users_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      #@user = User.cached_find(params[:id])
      @user = User.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(UserParams::ADMIN_PARAMS)  if super?
    end
end
