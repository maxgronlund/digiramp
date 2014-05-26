class AccountUsersController < ApplicationController

  include AccountsHelper
  include UsersHelper
  before_filter :access_to_account


  def index
    forbidden unless current_account_user && current_account_user.read_account_user
  end
  
  def show
    #@blog = Blog.cached_find('Account Users')
    #@client_permissions  = BlogPost.where(identifier: 'Client Permissions', blog_id: @blog.id)
    #                                     .first_or_create(identifier: 'Client Permissions', blog_id: @blog.id, title: 'Client Permissions', body: 'What this client can access')
    @account_user = AccountUser.cached_find(params[:id])
  end
  
  def new
    forbidden unless current_account_user.create_account_user
    
    @account_user = @account.account_users.new(role: "Associate")
    @roles = AccountUser::ROLES
    @roles.delete("Account Owner")
    @roles.delete("Client")
    
  end
  
  def create_user
    forbidden unless current_account_user.create_account_user
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
    
    forbidden unless current_account_user.create_account_user
    
    
    # missing email
    if params[:account_user][:email].to_s == ""
      flash[:danger] = { title: "Email can't be blank", body: "" }
      redirect_to new_account_account_user_path( @account )
    
    #  invalid email
    elsif /^\S+@\S+\.\S+$/.match(params[:account_user][:email]).nil?
      flash[:danger] = { title: "Invalid email", body: "" }
      redirect_to new_account_account_user_path( @account )
    end
    @user = User.where(email: params[:account_user][:email]).first
    
    # user alreaddy added to the account
    if @user && AccountUser.exists?(user_id: @user.id, account_id: @account.id)  
      # the account user was alreaddy created
      flash[:danger] = { title: "User already invited", body: "" }
      redirect_to new_account_account_user_path( @account )
    else
      # the user is signed up at digiramp
      if @user
        #create_account_user_for_existing @user
        @user.invite_existing_user_to_account( @account.id, params[:account_user][:invitation_message])
      else
        # there is no use in the system with that
        # so create a user first
        @user                     = create_user
        @user_account             = User.create_account_for @user
        @user.current_account_id  = @user_account.id
        @user.save!
        @user.invite_new_user_to_account( @account.id, params[:account_user][:invitation_message])
      
        # some caching stuff
        @user.account.version += 1
        @user.account.save
          
        
      end
      flash[:info] = { title: "User Invited", body: "An invitation is send to: #{ params[:account_user][:email]}" }
      # create an account user
      @account_user = AccountUser.create( account_id: @account.id, 
                                          user_id: @user.id, 
                                          role: params[:account_user][:role], 
                                          invitation_message: params[:account_user][:invitation_message],
                                          email: @user.email,
                                          name: @user.name)
      
      # add user to white list
      @account.permitted_user_ids << @account_user.user.id
      @account.permitted_user_ids.uniq!
      @account.save!
      
      # bounce back to list
      redirect_to edit_account_account_user_path @account, @account_user 
      
    end
  end
  
  #def create_account_user_for_existing user
  #  #if params[:account_user][:role] == 'Client'
  #  #  redirect_to :back
  #  #end
  #  flash[:info] = { title: "User invited", body: "An invitation is send to: #{ params[:account_user][:email]}" }
  #  @user.invite_existing_user_to_account( @account.id , @account_user.invitation_message )
  #end

  def edit
    
    forbidden unless current_account_user.update_account_user
    @account_user = AccountUser.cached_find(params[:id])
    #@roles        = AccountUser::ROLES
    #@roles.delete("Account Owner") #unless current_user.super?
    #@roles.delete("Client")

  end
  
  def update
    forbidden unless current_account_user.update_account_user
    
    @account_user = AccountUser.cached_find(params[:id])
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
    
    
    
    # users can always leave
    if current_account_user.id == account_user.id
      session[:return_url] = nil
      go_to = user_path(current_account_user.user)
      flash[:info] = { title: "You have leaved an account", body: "You have no more access to #{@account.title}" }
    else
      # only account users with the right permissions can delete users
      forbidden unless current_account_user.delete_account_user
      go_to = account_path(@account)
      flash[:info] = { title: "User removed", body: "the user has no more access to this account" }
    end
    
    
    
    # remove user from whitelist
    @account.permitted_user_ids -= [@account_user.user.id]
    # force update of uuids on this
    @account.save!
    
    # force update of uuids
    # on the account users account
    account_user.account.save!
    
    # remove the account user
    account_user.destroy

    
   
    redirect_to_return_url go_to
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
