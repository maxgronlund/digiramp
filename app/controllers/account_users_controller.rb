class AccountUsersController < ApplicationController

  before_filter :there_is_access_to_the_account


  def index
    
  end
  
  def show
    #@blog = Blog.cached_find('Account Users')
    #@client_permissions  = BlogPost.where(identifier: 'Client Permissions', blog_id: @blog.id)
    #                                     .first_or_create(identifier: 'Client Permissions', blog_id: @blog.id, title: 'Client Permissions', body: 'What this client can access')
    @account_user = AccountUser.cached_find(params[:id])
  end
  
  def new
    @account_user = @account.account_users.new(role: "Associate")
    @roles = AccountUser::ROLES
    @roles.delete("Account Owner")
    @roles.delete("Client")
    
  end
  
  def create_user
    # dont activate accounts for new users if their role is 'Client'
    activated = params[:account_user][:role] == 'Client' ? false : true
    # make a temporary password
    secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
    # create the user
    @user = User.create( email: params[:account_user][:email], 
                         name:  params[:account_user][:email], 
                         #current_account_id: @account.id, 
                         password: secret_temp_password, 
                         password_confirmation: secret_temp_password,
                         activated: activated)
    
    
  end
  
  

  def create
    # missing email
    if params[:account_user][:email].to_s == ""
      flash[:danger] = { title: "Email can't be blank", body: "" }
      redirect_to new_account_account_user_path( @account )
    
    #  invalid email
    elsif /^\S+@\S+\.\S+$/.match(params[:account_user][:email]).nil?
      flash[:danger] = { title: "Invalid email", body: "" }
      redirect_to new_account_account_user_path( @account )
      
    else
      # existing user
      if @user = User.where(email: params[:account_user][:email]).first
        create_account_user_for_existing @user
        @user.invite_existing_user_to_account( @account.id, params[:account_user][:invitation_message])
      else
        # there is no use in the system with that
        # so create a user first
        @user                     = create_user
        @user_account             = User.create_account_for @user
        @user.current_account_id  = @user_account.id
        @user.save!
        @user.invite_new_user_to_account( @account.id, params[:account_user][:invitation_message])
      
      end
      @user.account.version += 1
      @user.account.save
      begin
        # create an account user
        @account_user = AccountUser.create( account_id: @account.id, 
                                            user_id: @user.id, 
                                            role: params[:account_user][:role], 
                                            invitation_message: params[:account_user][:invitation_message],
                                            email: @user.email,
                                            name: @user.name)
                                            
                                            
        
        redirect_to @account_user.associate?   ?  account_account_user_path( @account , @account_user) : account_account_users_path( @account)
      
      rescue
        # the account user was alreaddy created
        flash[:danger] = { title: "User already invited", body: "" }
        redirect_to new_account_account_user_path( @account )
      end
      
    end
  end
  
  def create_account_user_for_existing user
    if params[:account_user][:role] == 'Client'
      redirect_to :back
    end
    flash[:info] = { title: "User invited", body: "An invitation is send to: #{ params[:account_user][:email]}" }
    @user.invite_existing_user_to_account( @account.id , 'Welcome to the party')
  end

  def edit
    
    @account_user = AccountUser.cached_find(params[:id])
    @roles = AccountUser::ROLES
    @roles.delete("Account Owner") #unless current_user.super?
    @roles.delete("Client")

  end
  
  def update

    @account_user = AccountUser.cached_find(params[:id])
    
    
    params[:account_user][:permission_key] = UUIDTools::UUID.timestamp_create().to_s
    
    # make sure to bounce back to the right place
    if params[:account_user][:edit_customer]
      session[:return_url] = account_customer_path( @account_user.account, @account_user)
      params[:account_user].delete :edit_customer
    end
    
    if params[:account_user][:invite_associate]
      session[:return_url] = account_account_users_path( @account_user.account, @account_user)
      params[:account_user].delete :invite_associate
    end
    
    if params[:account_user][:role] == "Associate"
      session[:return_url] = account_account_user_path(@account, @account_user)
    elsif  params[:account_user][:role] == "Administrator"
      session[:return_url] = account_account_users_path(@account)
    end
    
    @account_user.update(account_user_params)
    
    # administrator has full permissions
    #if @account_user.administrator?
    #  session[:return_url] = account_account_users_path( @account )
    #end

    redirect_to_return_url account_account_users_path(@account, @account_user)
    
    
  end
  
  def destroy
    account_user = AccountUser.cached_find(params[:id])
    account_user.account.version += 1
    account_user.account.save
    account_user.destroy
    
    

    
    flash[:info] = { title: "User removed", body: "the user has no more access to this account" }
    redirect_to_return_url account_path(@account)
    #redirect_to :back
  end
  
  
private

  #def invite( account, user, role )
  #  @account_user = AccountUser.where(account_id: account.id, user_id: user.id).first_or_create
  #  @account_user.update(account_id: params[:account_id], user_id: user.id, role: role)
  #  (params[:account_user][:permitted_models_attributes]||{}).each do |k,v|
  #    @account_user.permitted_models.where(permitted_model_type_id: v[:permitted_model_type_id]).first.update(v)
  #  end
  #  
  #end
  #
  def account_user_params
    #if current_user.can_administrate( @account)
      params.require(:account_user).permit!
      #end
  end
  #
  #def check_permitted_models
  #  PermittedModelType.all.each do |permitted_model_type|
  #    @account_user.permitted_models.where(  account_user_id: @account_user.id, permitted_model_type_id: permitted_model_type.id) .first_or_create(   account_user_id: @account_user.id,permitted_model_type_id: permitted_model_type.id)
  #  end
  #end
  
end
