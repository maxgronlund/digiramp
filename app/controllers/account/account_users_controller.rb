class Account::AccountUsersController < ApplicationController

  include AccountsHelper
  include UsersHelper
  #before_filter :access_account
  before_filter :get_account_account

  def index
    unless current_user.role == 'Super'
      forbidden unless current_account_user.read_user
    end
    @user       = current_user
    @authorized = true
    
    @subscriptions = @account.subscriptions
    
    #forbidden unless current_account_user && current_account_user.read_user
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
    @user       = current_user
    
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
    
    sanitized_email = EmailSanitizer.saintize params[:account_user][:email]

    # secure the permissions is in place
    unless current_user.role == 'Super'
      forbidden unless current_account_user.createx_user
    end
    
    # if the account user alreaddy exists
    if AccountUser.where(email: sanitized_email, account_id: params[:account_user][:account_id]).first
      flash[:info] =  "User already a member"                                   
    else
      # validate the email, returns to the user if unapproved
      validate_email
      
      
      
      # set the acces
      set_access
      
      # get the user and send invitation
      invited_user = User.invite_to_account_by_email( 
                                                      sanitized_email, 
                                                      params[:account_user][:invitation_title], 
                                                      params[:account_user][:invitation_message], 
                                                      @account.id,
                                                      current_user
                                                     )
     
      # If there allready is an account user for the invited user
      if @account_user = AccountUser.where(user_id: invited_user.id, account_id: @account.id).first
      
        # make sure the role is set to account user
        params[:account_user][:role] = 'Account User'
      
        # update the account user
        @account_user.update_attributes!(account_user_params)
        
        # logg the activity
        @account_user.create_activity(  :created, 
                                  owner: current_user,
                              recipient: @account_user,
                         recipient_type: @account_user.class.name,
                             account_id: @account.id)
      
      else
        # create new account user
        params[:account_user][:user_id] = invited_user.id
        params[:account_user][:role]    = 'Account User'
        @account_user = AccountUser.create!(account_user_params)
      end
      
      #channel = 'digiramp_radio_' + current_user.email
      #Pusher.trigger(channel, 'digiramp_event', {"title" => 'User already a member', 
      #                                      "message" => "#{params[:account_user][:email]} is already added", 
      #                                      "time"    => '7000', 
      #                                      "sticky"  => 'false', 
      #                                      "image"   => 'notice'
      #                                      })
      # 
    end
    # notice!
    # Permissions for the account user are copied to the catalog users
    # from the after_commit on the AccountUser#after_create => update_catalog_users
    @account.count_users
    redirect_to account_account_account_users_path @account
  end
  
  def validate_email
    # simple validation move to model
    # missing email
    
    if params[:account_user][:email].to_s == ""
      flash[:danger] = "Email can't be blank"
      redirect_to new_account_account_account_user_path( @account )
    
    #  invalid email
    elsif /^\S+@\S+\.\S+$/.match(params[:account_user][:email]).nil?
      flash[:danger] = "Invalid email"
      redirect_to new_account_account_account_user_path( @account )
    end
  end
  

  def edit
    forbidden unless current_account_user.update_user
    @account_user = AccountUser.cached_find(params[:id])
    @user         = current_user
  end
  
  def update

    forbidden unless current_account_user.update_user
    
    @account_user = AccountUser.cached_find(params[:id])
    
    
    set_access 
    
    # update the permission key will re-render cached views
    params[:account_user][:permission_key] = UUIDTools::UUID.timestamp_create().to_s
    
    # update the account user
    @account_user.update(account_user_params)
    
    @account_user.create_activity(  :updated, 
                              owner: current_user,
                          recipient: @account_user,
                     recipient_type: @account_user.class.name,
                         account_id: @account.id)
    
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
    
    account_user.create_activity(  :destroyed, 
                              owner: current_user,
                          recipient: account_user,
                     recipient_type: account_user.class.name,
                         account_id: @account.id)
                         
                         
    account_user.destroy!
    @account.count_users
    redirect_to account_account_account_users_path(@account)

  end
  
  
private

  def account_user_params
    params.require(:account_user).permit!
  end

  
end
