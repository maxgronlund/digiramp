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
    ap params
    # exclude ajax calls from statistic
    PageView.create(url: '/users' ) if request.format.to_s == 'text/html'

    if params[:commit] == 'Go'
      @whipe_users = true
      params.delete :commit
      session[:user_query] = params[:query]
    end
    
    session[:user_query] = nil if params[:clear] == 'clear'
    params[:query]  = session[:user_query]
    
    
    case params
      
    when :latest
      @users = User.public_profiles.order('created_at desc').page(params[:page]).per(8)
    
    when :featured
      @users = User.public_profiles.where(featured: true).order('featured_date desc').page(params[:page]).per(8)
    
    when :followers
      @users = User.public_profiles.order('uniq_followers_count desc').page(params[:page]).per(8)
    
    when :composer
      @users = User.public_profiles.where(composer: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    when :writer
      @users = User.public_profiles.where(writer: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    when :author
      @users = User.public_profiles.where(author: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    when :producer
      @users = User.public_profiles.where(producer: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    when :musician
      @users = User.public_profiles.where(musician: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    when :dj
      @users = User.public_profiles.where(dj: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    when :remixer
      @users = User.public_profiles.where(remixer: true).order('uniq_completeness desc').page(params[:page]).per(8)
    
    else
       @users = User.public_profiles.order('uniq_completeness desc').search(params[:query]).page(params[:page]).per(8)
    end


    @user  = current_user if current_user
    
  end

  def show

    not_found(params) unless @user
    if request.format.to_s == 'text/html'
      
      unless current_user && @user != current_user
       
        @user.views += 1 
        @user.save
        
        @user.create_activity(  :show, 
                                  owner: current_user,
                              recipient: @user,
                         recipient_type: @user.class.name,
                             account_id: @user.account_id)
                             
      end
    end 
    session[:account_id] = @user.account_id 
    
    if current_user 
      if current_user.current_account_id != current_user.account.id
        current_user.current_account_id  = current_user.account.id
        current_user.save!
      end
      @playlists  = current_user.playlists
      #@authorized = false
      #if current_user.id == @user.id || current_user.super?
      #  @authorized = true
      #end
    end
    @user_activities = @user.user_activities.order('id desc').page(params[:page]).per(4)
    unless @user.page_style
      @user.save!
    end
    @body_color =   @user.page_style.bgcolor
    @image_url  =   @user.page_style.backdrop_image
      
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
  
  #def find_user
  #  if current_user
  #    @user = User.cached_find(params[:id])
  #  else
  #    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  #  end
  #end


  def new
    @user = User.new
  end

  def edit
    @authorized = true
  end

  def create

    session[:show_profile_completeness] = true
    #params[:user][:role]                = 'Customer'
    params[:user][:show_introduction]   = true
    params[:user][:email].downcase! if params[:user][:email]
    @user                     = User.new(user_params)
      
    if @user.save
      @account          = User.create_a_new_account_for_the @user

      
      # signout if you was signed in as another user
      cookies.delete(:auth_token)
      sign_in

      @user.create_activity(  :created, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account_id) 

      @user.confirm_ips
      redirect_to edit_user_path(@user)

    else
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

    @user.create_activity(  :destroyed, 
                       owner: @user,
                   recipient: @user,
              recipient_type: @user.class.name,
                  account_id: @user.account_id)
    

    @user.destroy

    session[:go_to_after_edit]          = nil
    cookies.delete(:user_id)
    self.flush_auth_token_cache(cookies[:auth_token])
    session[:show_profile_completeness] = nil
    redirect_to :back
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
    params.require(:user).permit( :name,
                                 :password,
                                 :password_confirmation,
                                 :email,
                                 :admin,
                                 :image,
                                 :crop_params,
                                 :profile,
                                 :auth_token,                 
                                 :current_account_id,
                                 :first_name,                 
                                 :last_name,                  
                                 :avatar_url,                 
                                 :account_id,
                                 :show_welcome_message,       
                                 :activated,                  
                                 :uuid,                       
                                 :curent_catalog_id,
                                 :invited,                    
                                 :administrator,              
                                 :has_a_collection,           
                                 :old_role,                   
                                 :account_activated,          
                                 #:provider,                  
                                 #:uid,                        
                                 #:email_missing,      
                                 :writer,                     
                                 :author,                     
                                 :producer,                   
                                 :composer,                   
                                 :remixer,                    
                                 :musician,                   
                                 :dj,                         
                                 :user_name,                         
                                 :profession,                 
                                 :country,                    
                                 :city,                       
                                 :artist,              
                                 :gender,                    
                                 :link_to_facebook,           
                                 :link_to_twitter,            
                                 :link_to_linkedin,           
                                 :link_to_google_plus,        
                                 :link_to_homepage,           
                                 :initialized,                
                                 :short_description,
                                 :show_introduction,          
                                 :default_cms_page_id,
                                 :news_count,                 
                                 :page_style_id,
                                 :top_tag,                    
                                 :backdrop_image, 
                                 :link_to_tumblr,             
                                 :link_to_instagram,          
                                 :link_to_youtube,            
                                 :address,                    
                                 :zip_code,                   
                                 :phone_number 
                                 )
      
  end


end
