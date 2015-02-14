class Catalog::CatalogUsersController < ApplicationController
   
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog, only: [  :index,
                                          :new,
                                          :create,
                                          :edit,
                                          :update
                                       ]
                                       
  
  
  def index
    forbidden unless current_catalog_user.read_user
    #catalog_user_ids = @catalog.catalog_user_ids
    #
    #user_ids   = User.where(role: 'Super').pluck(:id)
    
    #@catalog        = Catalog.cached_find(params[:catalog_id])
  end
  
  
  def new
    forbidden unless current_catalog_user.create_user
    @catalog        = Catalog.cached_find(params[:catalog_id])
    
    
    blog      = Blog.cached_find('User Mailer')
    blog_post = BlogPost.cached_find('Invite Existing User To Catalog' , blog)
    
    
    
    @catalog_user   = CatalogUser.new( title: "You have been invited the #{@catalog.title.upcase!} catalog by #{current_user.name}", 
                                       body: "You can access the #{@catalog.title.upcase!} catalog from #{@catalog.account.title} on your controll panel",
                                       account_id: @catalog.account_id,
                                       uuid: UUIDTools::UUID.timestamp_create().to_s)
  end
  
  # create a new catalog user
  # send invitation by email
  def create
    forbidden unless current_catalog_user.create_user

    if email    = EmailValidator.saintize( params[:catalog_user][:email])
      title     = params[:catalog_user][:title]
      body      = params[:catalog_user][:body]
      catalog   = Catalog.cached_find(params[:catalog_user][:catalog_id])
      
      
      
      # if the user already is in the system
      if user    = User.where(email: email).first
      
        flash[:info] = { title: "User Invited: ", 
                         body: "You have invited a DigiRAMP member with the email #{email} to the #{catalog.title} catalog" 
                       }
        # send email
        UserMailer.delay.invite_user_to_catalog( email,
                                                 title, 
                                                 body,  
                                                 current_user.id,  
                                                 user.id,
                                                 @account.id,
                                                 catalog.id,   
                                                 true
                                                )
      else
        # invite a new user
        if user = User.invite_user( email )
          # send email
          UserMailer.delay.invite_user_to_catalog( email,
                                                   title, 
                                                   body,  
                                                   current_user.id, 
                                                   user.id, 
                                                   @account.id,
                                                   catalog.id,   
                                                   false
                                                  )
          
          flash[:info] = { title: "User Invited: ", body: "You have invited #{email} to the #{catalog.title.upcase} catalog" }
        else
          
        end
        
      end
      params[:catalog_user][:user_id]       = user.id 
      params[:catalog_user][:account_id]    = @account.id 
      params[:catalog_user][:uuid]          = UUIDTools::UUID.timestamp_create().to_s
      unless user && @catalog_user         = CatalogUser.create!( catalog_user_params ) 
        # notify if something went wrong
        flash[:danger] = { title: "Error: ", body: "User not invited, If this error persists please contact support" }
      end
      @catalog_user.attach_to_account_user
      @user = current_user
    else
      flash[:danger] = { title: "Error: ", body: "Unable to validate email" }
    end
    redirect_to catalog_account_catalog_catalog_users_path(@account, @catalog)
  end

  def edit
    forbidden unless current_catalog_user.update_user
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
  end
  
  def update
    forbidden unless current_catalog_user.update_user
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
    
    @catalog_user.update_attributes(catalog_user_params)


    redirect_to catalog_account_catalog_catalog_users_path(@account, @catalog)
  end
  
  
  def destroy
    forbiden unless current_account_user.delete_user
    
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
    
    account       = @catalog_user.account
    user          = @catalog_user.user
    account_user  = AccountUser.where(account_id: @catalog_user.account_id, user_id: @catalog_user.user_id).first
    


    # if the account user was created when the user was invited to a catalog
    if account_user && account_user.role == 'Catalog User'
      # and there is no more catalog users for the account user
      if CatalogUser.where(user_id: user.id, account_id: account.id, catalog_id: @catalog.id).first.nil?
        # It's safe do destroy the account user, unless the account user is the accoun owner ;-)
        account_user.destroy! unless account.user_id == account_user.user_id
      end
    end
    
    # delete the catalog user
    @catalog_user.destroy!
    redirect_to catalog_account_catalog_catalog_users_path(@account, @catalog)
    
  end
  
  private
  
  def catalog_user_params
    params.require(:catalog_user).permit!
  end
  
  def set_permission_on recordings
    
    
    
  end
  
  
end
