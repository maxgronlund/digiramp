class User::ContactsController < ApplicationController
  #before_action :set_contact, only: [:create]
  before_filter :access_user
  def index

    #session[:select_all_recordings] = false if params[:page].nil?
      
      
    
    @account    = @user.account
    @contacts  = Client.account_search(@account, params[:query]).order('name asc').page(params[:page]).per(16)
  end
  
  def show
    @contact = Client.cached_find(params[:id])
  end

  # GET /contacts/new
  def new 
    @contact = Client.new
  end


  def edit
    @contact   = Client.cached_find(params[:id])
  end
  
  def update
    @contact   = Client.cached_find(params[:id])
    @contact.update(client_params)
    redirect_to user_user_contact_path( @user, @contact )

  end


  def create
    @message = 'Contact created'
    if email = EmailSanitizer.saintize( params[:client][:email] )
      params[:client][:email] = email
      unless @user.clients.where(email: email ).present?
        Client.create(client_params)
      else
        @message = "A contact with the email: #{email} already exists"
        
      end
    else
      @message = 'Invalid email'
      
    end
    @contact = Client.new
    #redirect_to user_user_contact_path( @user, @contact )
    
  end
  
  def destroy
    client = Client.cached_find(params[:id])
    client.destroy!
    @contact_id = params[:id]
  end
  

  private


    def client_params
      params.require(:client).permit!
    end
end
