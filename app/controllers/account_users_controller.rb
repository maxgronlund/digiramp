class AccountUsersController < ApplicationController

  include AccountsHelper
  include UsersHelper
  before_filter :access_account


  def index
    forbidden unless current_account_user && current_account_user.read_user
  end
  
  def show
    #@blog = Blog.cached_find('Account Users')
    #@client_permissions  = BlogPost.where(identifier: 'Client Permissions', blog_id: @blog.id)
    #                                     .first_or_create(identifier: 'Client Permissions', blog_id: @blog.id, title: 'Client Permissions', body: 'What this client can access')
    @account_user = AccountUser.cached_find(params[:id])
  end
  
  def new
    forbidden unless current_account_user.createx_user
    
    @account_user = @account.account_users.new( role: "Associate", 
                                                invitation_title: "You have been invited to a DigiRAMP Account by #{current_user.name}",
                                                invitation_message: "You are invited to an account on DigiRAMP, please sign in to your account and you will find a new account on your dashboard")
    @roles = AccountUser::ROLES
    @roles.delete("Account Owner")
    @roles.delete("Client")
    
  end
  
  def create_user
    forbidden unless current_account_user.createx_user
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
  
  
  # create an account user and send an invitation email
  def create
    # secure the permissions is in place
    forbidden unless current_account_user.createx_user
    
    # validate the email
    validate_email
    
    # get the user and send invitation
    invited_user = User.invite_to_account_by_email( 
                                                    params[:account_user][:email], 
                                                    params[:account_user][:invitation_title], 
                                                    params[:account_user][:invitation_message], 
                                                    @account.id
                                                   )
   
    # If there allready is an account user for the invited user
    if @account_user = AccountUser.where(user_id: invited_user.id, account_id: @account.id).first
  
      # make sure the role is set to account user
      params[:account_user][:role] = 'Account User'
  
      # update the account user
      @account_user.update_attributes!(account_user_params)
  
    else
      # create new account user
      params[:account_user][:user_id] = invited_user.id
      params[:account_user][:role]    = 'Account User'
      @account_user = AccountUser.create!(account_user_params)
    end
    # notice!
    # Permissions for the account user are copied to the catalog users
    # from the after_commit on the AccountUser#after_create => update_catalog_users
    
    redirect_to account_account_users_path @account
  end
  
  def validate_email
    # simple validation move to model
    # missing email
    if params[:account_user][:email].to_s == ""
      flash[:danger] = { title: "Email can't be blank", body: "" }
      redirect_to new_account_account_user_path( @account )
    
    #  invalid email
    elsif /^\S+@\S+\.\S+$/.match(params[:account_user][:email]).nil?
      flash[:danger] = { title: "Invalid email", body: "" }
      redirect_to new_account_account_user_path( @account )
    end
  end
  

  def edit
    
    forbidden unless current_account_user.update_user
    @account_user = AccountUser.cached_find(params[:id])
    #@roles        = AccountUser::ROLES
    #@roles.delete("Account Owner") #unless current_user.super?
    #@roles.delete("Client")

  end
  
  def update
    forbidden unless current_account_user.update_user
    
    @account_user = AccountUser.cached_find(params[:id])
    
    # update the permission key will re render cached views
    params[:account_user][:permission_key] = UUIDTools::UUID.timestamp_create().to_s
    
    # update the account user
    @account_user.update(account_user_params)
    
    
    # update the white list for the account
    #RecordingsWorker.perform_async(@account_user.id)
    
    # update the white list for the recordings
    
    
    redirect_to account_account_users_path(@account)

  end
  
  def destroy
    account_user = AccountUser.cached_find(params[:id])
    
    #if current_account_user.delete_user
    #  redirect_to :back
    #else
    #  forbidden
    #end
    
    #if current_user.account_id == @account.id
    #  forbidden
    #else
    @account.permitted_user_ids -= [account_user.user_id]
    @account.save!
    account_user.destroy!
    redirect_to :back
    #end
    
    
    
    # users can always leave
    #if current_account_user.id == account_user.id
    #  session[:return_url] = nil
    #  go_to = user_path(current_account_user.user)
    #  flash[:info] = { title: "You have leaved an account", body: "You have no more access to #{@account.title}" }
    #else
    #  # only account users with the right permissions can delete users
    #  forbidden unless current_account_user.delete_user
    #  go_to = account_path(@account)
    #  flash[:info] = { title: "User removed", body: "the user has no more access to this account" }
    #end
    #
    #
    #
    ## remove user from whitelist
    #@account.permitted_user_ids -= [account_user.user.id]
    ## force update of uuids on this
    #@account.save!
    #
    ## force update of uuids
    ## on the account users account
    #account_user.account.save!
    #
    ## remove the account user
    #account_user.destroy
    #
    #
    #
    #redirect_to_return_url go_to
    
    
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
