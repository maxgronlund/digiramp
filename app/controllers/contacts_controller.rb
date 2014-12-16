class ContactsController < ApplicationController
  #before_action :set_contact, only: [:create]


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



  private


    def contact_params
      params.require(:contact).permit(:email, :title, :body)
    end
end
