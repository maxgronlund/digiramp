class Account::AccountUsersController < ApplicationController

  include AccountsHelper
  include UsersHelper
  before_filter :access_account


  def index
    ap current_account_user
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
    
    # set the acces
    set_access
    
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
    
    redirect_to account_account_account_users_path @account
  end
  
  def validate_email
    # simple validation move to model
    # missing email
    if params[:account_user][:email].to_s == ""
      flash[:danger] = { title: "Email can't be blank", body: "" }
      redirect_to new_account_account_account_user_path( @account )
    
    #  invalid email
    elsif /^\S+@\S+\.\S+$/.match(params[:account_user][:email]).nil?
      flash[:danger] = { title: "Invalid email", body: "" }
      redirect_to new_account_account_account_user_path( @account )
    end
  end
  

  def edit
    
    forbidden unless current_account_user.update_user
    @account_user = AccountUser.cached_find(params[:id])


  end
  
  def update
    forbidden unless current_account_user.update_user
    
    @account_user = AccountUser.cached_find(params[:id])
    
    
    set_access 
    
    # update the permission key will re-render cached views
    params[:account_user][:permission_key] = UUIDTools::UUID.timestamp_create().to_s
    
    # update the account user
    @account_user.update(account_user_params)
    
    # copy permissions to all catalogs 
    @account_user.update_catalog_users

    
    
    redirect_to account_account_account_users_path(@account)

  end
  
  # set the access
  def set_access 
    has_access   = false
    has_access   = true if params[:account_user][:read_crm]
    has_access   = true if params[:account_user][:read_opportunity]
    has_access   = true if params[:account_user][:read_client]
    has_access   = true if params[:account_user][:read_recording]
    has_access   = true if params[:account_user][:read_file]
    has_access   = true if params[:account_user][:read_legal_document]
    has_access   = true if params[:account_user][:read_financial_document]
    has_access   = true if params[:account_user][:read_common_work]
    has_access   = true if params[:account_user][:read_user]
    has_access   = true if params[:account_user][:read_catalog]
    has_access   = true if params[:account_user][:read_playlist]
    has_access   = true if params[:account_user][:read_crm]
    has_access   = true if params[:account_user][:read_artwork]
    has_access   = true if params[:account_user][:read_client]
    has_access   = true if params[:account_user][:read_file]
    has_access   = true if params[:account_user][:read_opportunity]
    has_access   = true if params[:account_user][:read_client]
    has_access   = true if params[:account_user][:role] == 'Super'
    params[:account_user][:access_account]  = has_access
    
    
  end
  
  def destroy
    account_user = AccountUser.cached_find(params[:id])
    account_user.destroy!
    redirect_to account_account_account_users_path(@account)

  end
  
  
private

  def account_user_params
    params.require(:account_user).permit!
  end

  
end
