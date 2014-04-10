class UsersController < ApplicationController
  respond_to :html, :xml, :json, :js
  #before_filter :account
  before_filter :find_user, only: [:show, :edit, :update, :destroy]
  #before_filter :add_roles, only: [:show, :new, :edit]
  #before_filter :there_is_access_to_the_account
  
  #def index
  #  @users = User.all
  #end

  def show

  end

  def new

  end

  def edit

  end

  def create
    #if User.where(email: params[:user][:email]).nil?
      
      params[:user][:name]   = User::SECRET_NAME
      params[:user][:role]   = 'cuctomer'
      params[:user][:email]  = params[:user][:email].downcase
      @user = User.new(user_params)
      blog              = Blog.cached_find('Sign Up')
      if @user.save
       
        @account          = User.create_a_new_account_for_the @user
        blog              = Blog.cached_find('Sign Up')
        blog_post         = BlogPost.cached_find('Sucess', blog)
        flash[:success]   = { title: blog_post.title, body: blog_post.body }
        
        # signout if you was signed in as another user
        cookies.delete(:auth_token)
        sign_in
        @user.account.raise_cache_version
        redirect_to account_path(@account)
      else
        blog_post         = BlogPost.cached_find('Error', blog)
        flash[:error]   = { title: blog_post.title, body: blog_post.body }
        #flash[:error] = { title: "Error", body: "Something went wrong, please check Password. Password confirmation and email, you might already have an account?" }
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
    @account = @user.account
    if @user.update(user_params)
      flash[:info] = { title: "SUCCESS: ", body: "#{@user.name} successfully updatet" }
      #@user.activity_events.create! \
      #  activity_log_id: @account.activity_log.id,
      #  user_id: current_user.id,
      #  title: "Updated #{@user.name}",
      #  r: true,
      #  activity_url: account_user_path( @account, @user)
      account = Account.cached_find(@user.account_id)
      account.rec_cache_version += 1 
      account.save! 
      
      @user.flush_auth_token_cache(cookies[:auth_token])

      redirect_to_return_url user_path(@user)
    else
      flash[:danger] = { title: "Error", body: "Check if password and password confirmation matched" }
      redirect_to_return_url edit_user_path( @user)
    end
    
  end

  def destroy
    @user.activity_events.create! \
      activity_log_id: @account.activity_log.id,
      user_id: current_user.id,
      title: "Deleted #{@user.name}",
      r: true,
      activity_url: account_users_path( @account)
    flash[:info] = { title: "SUCCESS: ", body: "#{@user.name} is deleted" } 
    @user.destroy
    #go_to = session[:go_to_after_edit] || account_users_path(@account)
    session[:go_to_after_edit]  = nil
    redirect_to :back
  end
  
  
private

  def remove_password_fields_if_blank!(user_params)
    if user_params[:password].blank? and user_params[:password_confirmation].blank?
      user_params.delete :password
      user_params.delete :password_confirmation
    end
  end

  def user_params
    if current_user && current_user.can_edit?
      params.require(:user).permit! 
    else
      params.require(:user).permit(:name, :email, :image, :crop_params, :password, :password_confirmation, :profile, :commit, :show_welcome_message, :role)
    end 
  end
          
  
  
  
  def find_user
    if current_user
      @user = User.cached_find(params[:id])
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
  
  
  

  
  #def add_roles
  #  @roles = AccountUser::ROLES
  #  @roles << 'super'           if current_user.super?
  #  @roles << 'account owner'   if current_user.super?
  #  @roles.uniq!
  #end

end
