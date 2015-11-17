class UsersController < ApplicationController
  #respond_to :html, :xml, :json, :js
 
  #before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :access_user, only: [:edit, :update, :destroy, :dont_show_instructions]
  before_action :find_user, only: [:show]
  protect_from_forgery only: [:edit, :create, :sign_in, :update]
  
  
  
  def omniauth_failure 
    #!!! make a custom screen
    
    #redirect wherever you want.
    redirect_to root_path
  end
  
  def index

    # exclude ajax calls from statistic
    PageView.create(url: '/users' ) if request.format.to_s == 'text/html'

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
    
    elsif params[:composer]
      @users = User.public_profiles.where(composer: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    elsif params[:writer]
      @users = User.public_profiles.where(writer: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    elsif params[:author]
      @users = User.public_profiles.where(author: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    elsif params[:producer]
      @users = User.public_profiles.where(producer: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    elsif params[:musician]
      @users = User.public_profiles.where(musician: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    elsif params[:dj]
      @users = User.public_profiles.where(dj: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    elsif params[:remixer]
      @users = User.public_profiles.where(remixer: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    else
       @users = User.public_profiles.order('uniq_completeness desc').search(params[:query]).page(params[:page]).per(8)
    end


    @user  = current_user if current_user
    
  end

  def show
    return not_found unless @user
    
    
    if request.format.to_s == 'text/html'
      
      unless current_user && @user.id == current_user.id
       
        @user.views += 1 
        @user.save
        
        @user.create_activity(  :show, 
                                  owner: current_user,
                              recipient: @user,
                         recipient_type: @user.class.name,
                             account_id: @user.account.id)
                             
      end
    end 
    session[:account_id] = @user.account.id 
    
    if current_user 
      if current_user.current_account_id != current_user.account.id
        current_user.current_account_id  = current_user.account.id
        current_user.save!
      end
      @playlists  = current_user.playlists

    end
    if current_user && current_user.id == @user.id
      @wall_posts = @user.wall_posts.order('id desc').page(params[:page]).per(4)
    else
      @wall_posts = @user.wall_posts.where(user_id: @user.id).order('id desc').page(params[:page]).per(4)
    end
    #@user_activities = @user.user_activities.order('id desc').page(params[:page]).per(4)
    unless @user.page_style
      @user.save!
    end
    
    @body_color =   @user.page_style.bgcolor rescue '#FFF'
    @image_url  =   @user.page_style.backdrop_image rescue '#FFF'
      
    #@image_url  = "https://digiramp.com/uploads/raw_image/image/24/music-enthusiasts.jpg"
    @hide_sidebar_toggle  = true
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

  def new
    #redirect_to user_path(current_user) if current_user
    #if params[:recording_id]
    #  session[:share_recording_id] = params[:recording_id]
    #else
    #  session[:share_recording_id] = nil
    #end
    #@user = User.new
    redirect_to user_path(current_user) if current_user
    if params[:recording_id]
      session[:share_recording_id] = params[:recording_id]
    else
      session[:share_recording_id] = nil
    end
  end

  def edit
    #@authorized = true
  end

  def create
    
    session[:show_profile_completeness] = true
    params[:user][:show_introduction]   = true
    params[:user][:name]                = params[:user][:user_name]
    params[:user][:email].downcase! if params[:user][:email]
    params[:user][:private_profile]    = true
    
    @user = User.new(user_params)
    
    if @user.save
      ap '========================================================================================='
      ap @user
      ap '========================================================================================='
      finished("landing_page")
      finished("invitation_from_user")
      
      DefaultAvararJob.perform_later @user.id
      UserAssetsFactory.new @user
      # signout if you was signed in as another user
      cookies.delete(:auth_token)
      

      @user.create_activity(  :created, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account.id) 


      #sign_in
      UserMailer.delay.confirm_signup( @user.id )
      redirect_to signup_confirmations_path
      #redirect_to user_user_user_configurations_path(@user)
    else
      flash[:danger] = "Please check email and password" 
      render :new
    end

  end

  def sign_in
    
    
    if @user && @user.authenticate(@user.password)
      cookies[:auth_token] = @user.auth_token
      
      @user.create_activity(  :signed_in, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account.id) 
                
                
    end
  end

  def update
    @account    = @user.account

    @user.slug  = nil
    params[:user][:email_missing] = false
    params[:user][:initialized]   = true
    #params[:user][:name]          = params[:user][:user_name] if params[:user][:user_name]
    if @user.update(user_params)
      @user.update_meta
      @user.save!
      # show completeness 
      session[:show_profile_completeness] = true
      @user.flush_auth_token_cache(cookies[:auth_token])

      @user.create_activity(  :updated, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account.id)
                    
                    
                    
      if @account.account_type == 'Social'
        @account.title = @user.user_name
        @account.save!
      end
      if params[:commit] == 'Save info'       
        redirect_to user_user_control_panel_index_path(@user)  
      else                               
        redirect_to user_path(@user)
      end
    else
      render :edit
    end
    
  end

  def destroy

    if @user.permits?(current_user)
      
      begin 
        user = User.cached_find_by_auth_token( cookies[:auth_token] )
        user.flush_auth_token_cache(cookies[:auth_token])
      
        user.create_activity(  :logged_out, 
                           owner: user,
                       recipient: user,
                  recipient_type: user.class.name,
                      account_id: user.account.id)       
      rescue
      end
      cookies.delete(:auth_token)
      cookies.delete(:user_id)
    
      session[:share_recording_id]        = nil
      session[:show_profile_completeness] = nil
      session[:request_url]               = nil
      session[:go_to_after_edit]          = nil
      @user.flush_auth_token_cache(cookies[:auth_token])
      
      DeleteUserJob.perform_later @user.id
      current_user = nil
      redirect_to root_path
    else
      forbidden
    end
  end
  
  def dont_show_instructions
    @user.show_introduction = false
    @user.save!
  end
  
  
private


  def remove_password_fields_if_blank!(user_params)
    if user_params[:password].blank? and user_params[:password_confirmation].blank?
      user_params.delete :password
      user_params.delete :password_confirmation
    end
  end

  def user_params
    params.require(:user).permit( UserParams::PUBLIC_PARAMS ) 
  end


end
