class User::ContactsController < ApplicationController
  #before_action :set_contact, only: [:create]
  before_filter :access_user
  def index
    @account = @user.account
    @contacts  = Client.account_search(@account, params[:query]).order('name asc').page(params[:page]).per(256)
  end
  
  def show
  end

  # GET /contacts/new
  def new 
    
    @contact = Contact.new
  end


  def edit
  end


  def create
    @contact = Contact.create(contact_params)

    redirect_to :back
  end
  
  def destroy
    client = Client.cached_find(params[:id])
    client.destroy
    @contact_id = params[:id]
  end



  private


    def contact_params
      params.require(:contact).permit(:email, :title, :body)
    end
end
