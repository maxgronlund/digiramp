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
    #@catalog        = Catalog.cached_find(params[:catalog_id])
  end
  
  
  def new
    forbidden unless current_catalog_user.create_user
    @catalog        = Catalog.cached_find(params[:catalog_id])
    
    
    blog      = Blog.cached_find('User Mailer')
    blog_post = BlogPost.cached_find('Invite Existing User To Catalog' , blog)
    
    
    
    @catalog_user   = CatalogUser.new( title: "You have been invited the #{@catalog.title.upcase!} Catalog by #{current_user.name}", 
                                       body: "You can access the #{@catalog.title.upcase!} Catalog from #{@catalog.account.title} on your HOME screen")
  end
  
  # create a new catalog user
  # send invitation by email
  def create
    forbidden unless current_catalog_user.create_user
    
    email   = params[:catalog_user][:email]
    title   = params[:catalog_user][:title]
    body    = params[:catalog_user][:body]
    catalog = Catalog.cached_find(params[:catalog_user][:catalog_id])
    
  
    
    # if the user already is in the system
    if @user    = User.where(email: email).first

      flash[:info] = { title: "User Invited: ", 
                       body: "You have invited a DigiRAMP member with the email #{email} to the #{catalog.title} catalog" 
                     }
      
      # invite existing user to catalog
      UserMailer.delay.invite_existing_user_to_catalog( @user.id, 
                                                        title, 
                                                        body, 
                                                        catalog.id 
                                                      )
      
      # force the user uuid to update
      @user.save!
      
    else
      # invite a new user
      if @user = User.invite_user( email )

        # send invitation email for to new DigiRAMP account and the catalog
        UserMailer.delay.invite_new_user_to_catalog(  @user.id, 
                                                      title, 
                                                      body,  
                                                      catalog.id 
                                                    )
        
        # confirm for current user
        flash[:info] = { title: "User Invited: ", body: "You have invited #{email} to the #{catalog.title.upcase} catalog" }
      else
        
      end
      
    end
    params[:catalog_user][:user_id]       = @user.id 
    params[:catalog_user][:account_id]    = @account.id 
    unless @user && @catalog_user         = CatalogUser.create!( catalog_user_params ) 
      # notify if something went wrong
      flash[:danger] = { title: "Error: ", body: "User not invited, If this error persists please contact support" }
    end
    @catalog_user.attach_to_account_user
    redirect_to catalog_account_catalog_catalog_users_path(@account, @catalog)
  end

  def edit
    forbidden unless current_catalog_user.update_user
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
  end
  
  def update
    puts '++++++++++++++++++++++++++++  UPDATE +++++++++++++++++++++++++++++++++++++++'
    puts '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    puts '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
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
    
    # store account and user
    account       = @catalog_user.account
    user          = @catalog_user.user
    account_user = AccountUser.where(account_id: @catalog_user.account_id, user_id: @catalog_user.user_id).first
    
    begin
      @catalog_user.destroy!
    rescue
    end
    # if the account user was created when the user was invited to a scatlog
    if account_user.role == 'Catalog User'
      # and there is no more catalog users for the account user
      if CatalogUser.where(user_id: user.id, account_id: account.id, catalog_id: @catalog.id).first.nil?
        
        # It's safe do destroy the account user, unless the account user is the accoun owner ;-)
        account_user.destroy! unless account.user_id == account_user.user_id
      end
    end
    
    redirect_to catalog_account_catalog_catalog_users_path(@account, @catalog)
    
  end
  
  private
  
  def catalog_user_params
    params.require(:catalog_user).permit!
  end
  
  def set_permission_on recordings
    
    
    
  end
  
  
end
