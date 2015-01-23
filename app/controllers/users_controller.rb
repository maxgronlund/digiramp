class UsersController < ApplicationController
  #respond_to :html, :xml, :json, :js
 
  #before_filter :find_user, only: [:show, :edit, :update, :destroy]
  before_filter :access_user, only: [:edit, :update, :destroy]
  before_filter :find_user, only: [:show]
  protect_from_forgery only: :index
  
  def omniauth_failure 
    #!!! make a custom screen
    
    #redirect wherever you want.
    redirect_to root_path
  end
  
  def index
  
    
    
    if params[:commit] == 'Go'
      @whipe_users = true
      params.delete :commit
      session[:user_query] = params[:query]
    end
    
    session[:user_query] = nil if params[:clear] == 'clear'
    params[:query]  = session[:user_query]
    
    
    
    if params[:latest]
      @users = User.public_profiles.order('created_at desc').page(params[:page]).per(8)
    
    elsif params[:featured]
      @users = User.public_profiles.where(featured: true).order('featured_date desc').page(params[:page]).per(8)
    
    elsif params[:followers]
      @users = User.public_profiles.order('uniq_followers_count desc').page(params[:page]).per(8)
    
    else
       @users = User.public_profiles.order('uniq_completeness desc').search(params[:query]).page(params[:page]).per(8)
    end


    @user  = current_user if current_user
    
  end

  def show

    if current_user && @user != current_user
      @user.views += 1 
      @user.save
    end
    
    @user.create_activity(  :show, 
                              owner: current_user,
                          recipient: @user,
                     recipient_type: @user.class.name,
                         account_id: @user.account_id)

    session[:account_id] = @user.account_id 
    
    if current_user 
      if current_user.current_account_id != current_user.account.id
        current_user.current_account_id  = current_user.account.id
        current_user.save!
      end
      @playlists  = current_user.playlists
      @authorized = false
      if current_user.id == @user.id || current_user.super?
        @authorized = true
      end
    end

  end
  
  def find_user
    begin
      @user = User.cached_find(params[:id])
      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the post_path, and we should do
      # a 301 redirect that uses the current friendly id.
      if request.path != user_path(@user)
        return redirect_to @user, :status => :moved_permanently
      end
    rescue
      not_found
    end
  end
  
  #def find_user
  #  if current_user
  #    @user = User.cached_find(params[:id])
  #  else
  #    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  #  end
  #end


  def new

  end

  def edit
    @authorized = true
  end

  def create
    session[:show_profile_completeness] = true
    params[:user][:role]      = 'Customer'
    params[:user][:email].downcase! if params[:user][:email]
    user_name                 = User.create_uniq_user_name_from_email (params[:user][:email])
    params[:user][:user_name] = user_name
    @user                     = User.new(user_params)
                              
    blog                      = Blog.cached_find('Sign Up')

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
      
      
      
      
      
      
      redirect_to edit_user_path(@user)
      
      
      
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
    @account    = @user.account

    @user.slug  = nil
    params[:user][:email_missing] = false
    params[:user][:initialized]   = true
    if @user.update(user_params)
      # show completeness if needed
      session[:show_profile_completeness] = true
      @user.flush_auth_token_cache(cookies[:auth_token])

      @user.create_activity(  :updated, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account_id)
                    
                    
                    
      if @account.account_type == 'Social'
        @account.title = @user.user_name
        @account.save!
      end
                                            
      redirect_to user_path(@user)
    else
      #if User.where(user_name: params[:user_name])
      #  flash[:danger] = { title: "Error", body: "User name alreaddy used" }
      #else
      #  flash[:danger] = { title: "Error", body: "Check if password and password confirmation" }
      #end
      
      render :edit
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
    session[:go_to_after_edit]          = nil
    cookies.delete(:user_id)
    self.flush_auth_token_cache(cookies[:auth_token])
    session[:show_profile_completeness] = nil
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
          
  
  
  
  #def find_user
  #  if current_user
  #    @user = User.cached_find(params[:id])
  #  else
  #    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  #  end
  #end
  
  
  
  

  
  #def add_roles
  #  @roles = AccountUser::ROLES
  #  @roles << 'super'           if current_user.super?
  #  @roles << 'account owner'   if current_user.super?
  #  @roles.uniq!
  #end

end
