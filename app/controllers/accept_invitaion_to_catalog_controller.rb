class AcceptInvitaionToCatalogController < ApplicationController
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    @catalog = Catalog.cached_find(params[:shared_catalog_id])
  end
  
  def update
    @user     = User.find_by_password_reset_token!(params[:id])
    @catalog  = Catalog.cached_find(params[:catalog][:catalog_id])
    password  = params[:catalog][:password]
    
    logger.debug '------------------------------------'
    logger.debug params
    logger.debug '-------------------------------------'
    
    params = nil
    params = {"user" => { "id" => @user.id, "password" => password}}
    
    logger.debug '------------------------------------'
    logger.debug params
    logger.debug '-------------------------------------'
    
    #params[:user]             = 'user'.to_sym
    #params[:user][:password]  = params[:catalog][:password]
    
    
    if @user.password_reset_sent_at < 2.weeks.ago

      redirect_to :back
    else
      @user.password  = password
      @user.invited   = true
      @user.save
      
      
      cookies.permanent[:auth_token]  = nil
      cookies[:auth_token]            = @user.auth_token  
      
      redirect_to account_path( @user.account) 
      

    end
    

    
  end
  
  def user_params
    #if can_edit?
      params.require(:user).permit!
    #end
  end
end
