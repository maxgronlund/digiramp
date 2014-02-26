class UsersController < ApplicationController
  respond_to :html, :xml, :json, :js
  #before_filter :account
  before_filter :find_user, only: [:show, :edit, :update, :destroy]
  #before_filter :add_roles, only: [:show, :new, :edit]
  
  
  def index
    @users = User.all

  end

  def show
    

  end

  def new

  end

  def edit

  end

  def create
    #if User.where(email: params[:user][:email]).nil?
      @user = User.new(user_params)
      
      if @user.save!
        @account = Account.create(title: @user.email, 
                                  user_id: @user.id, 
                                  expiration_date: Date.current()>>3,
                                  administrator_id: @user.id,
                                  contact_email: @user.email,
                                  visits: 1,
                                  account_type: 'free account' )
                                  
        AccountUser.create(user_id: @user.id, account_id: @account.id, role: 'Administrator')
        
        @user.account_id          = @account.id
        @user.current_account_id  = @account.id
        @user.save!
        flash[:info] = { title: "Success", body: "you are signed up" }
        
        # signout if you was signed in as another user
        cookies.delete(:auth_token)
        sign_in
        redirect_to account_path(@account)
      else
        flash[:error] = { title: "Error", body: "Something went wrong, please check Password. Password confirmation and email, you might already have an account?" }
        redirect_to root_path
      end
    #else
    #  flash[:error] = { title: "Error", body: "A user with that email is already signed up" }
    #  redirect_to root_path
    #end
  end
  
  
  def sign_in
    if @user && @user.authenticate(@user.password)
      cookies[:auth_token] = @user.auth_token
    end
  end

  def update
    if @user.update(user_params)
      flash[:info] = { title: "Success", body: "#{@user.name} successfully updatet" }
      #@user.activity_events.create! \
      #  activity_log_id: @account.activity_log.id,
      #  user_id: current_user.id,
      #  title: "Updated #{@user.name}",
      #  r: true,
      #  activity_url: account_user_path( @account, @user)
      redirect_to user_path(@user)
    else
      flash[:error] = { title: "Error", body: "Check if password and password confirmation matched" }
      redirect_to edit_user_path( @user)
    end
    
  end

  def destroy
    @user.activity_events.create! \
      activity_log_id: @account.activity_log.id,
      user_id: current_user.id,
      title: "Deleted #{@user.name}",
      r: true,
      activity_url: account_users_path( @account)
    flash[:info] = { title: "Success", body: "#{@user.name} is deleted" } 
    @user.destroy
    #go_to = session[:go_to_after_edit] || account_users_path(@account)
    session[:go_to_after_edit]  = nil
    redirect_to :back
  end
  
private

  def user_params
    params.require(:user).permit!
  end
  
  def find_user
    @user = User.find(params[:id])
  end
  
  #def find_account
  #  @account = Account.find(params[:account_id])
  #end
  
  #def add_roles
  #  @roles = AccountUser::ROLES
  #  @roles << 'super'           if current_user.super?
  #  @roles << 'account owner'   if current_user.super?
  #  @roles.uniq!
  #end

end
