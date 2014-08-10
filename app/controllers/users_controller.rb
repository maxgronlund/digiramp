class UsersController < ApplicationController
  #respond_to :html, :xml, :json, :js
 
  #before_filter :find_user, only: [:show, :edit, :update, :destroy]
  before_filter :access_user, only: [:show, :edit, :update, :destroy, :index]

  def show
    if @user.account_id.nil?
       @user.account_id = Account.where(user_id: @user.id).first.id
       @user.save!
    end
    session[:account_id] = @user.account_id 
    if current_user.current_account_id != current_user.account.id
      current_user.current_account_id  = current_user.account.id
      current_user.save!
    end

  end

  def new

  end

  def edit

  end

  def create
  
    params[:user][:role]    = 'Customer'
    params[:user][:email].downcase! if params[:user][:email]
    @user                   = User.new(user_params)
    blog                    = Blog.cached_find('Sign Up')
    ap params
    if params[:user][:password]    != params[:user][:password_confirmation]
      flash[:danger]   = { error: 'Sorry:', body: 'Password and Passoword confirmation mismatch' }
      redirect_to signup_index_path
    elsif  params[:user][:email].to_s == ''
      flash[:danger]   = { error: 'Sorry:', body: 'Email is missing' }
      redirect_to signup_index_path
    elsif @user.save
      @account          = User.create_a_new_account_for_the @user
      blog              = Blog.cached_find('Sign Up')
      blog_post         = BlogPost.cached_find('Sucess', blog)
      flash[:success]   = { title: blog_post.title, body: blog_post.body }
      
      # signout if you was signed in as another user
      cookies.delete(:auth_token)
      sign_in
      
      
      @user.create_activity(  :created, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account_id) 
      
      
      
      redirect_to user_path(@user)
      
    else
      flash[:danger]   = { title: 'Sorry:', body: 'Email has already been taken' }
      redirect_to signup_index_path
    end

  end

  def sign_in
    if @user && @user.authenticate(@user.password)
      cookies[:auth_token] = @user.auth_token
      
      @user.create_activity(  :signed_in, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account_id) 
                
                
    end
  end

  def update
    @account = @user.account
    if @user.update(user_params)
      flash[:info] = { title: "SUCCESS: ", body: "#{@user.name} successfully updatet" }

      @user.flush_auth_token_cache(cookies[:auth_token])
      
      @user.create_activity(  :updated, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account_id)

      redirect_to user_path(@user)
    else
      flash[:danger] = { title: "Error", body: "Check if password and password confirmation matched" }
      
      redirect_to user_path( @user)
    end
    
  end

  def destroy
    #@user.activity_events.create! \
    #  activity_log_id: @account.activity_log.id,
    #  user_id: current_user.id,
    #  title: "Deleted #{@user.name}",
    #  r: true,
    #  activity_url: account_users_path( @account)
    
    @user.create_activity(  :destroyed, 
                       owner: @user,
                   recipient: @user,
              recipient_type: @user.class.name,
                  account_id: @user.account_id)
    
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
    params.require(:user).permit!
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
