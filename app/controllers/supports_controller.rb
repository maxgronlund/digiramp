class SupportsController < ApplicationController
  def index
    forbidden unless current_user
    @user = current_user
  end
  
  def create
    ap params
    flash[:info] = { title: "Message send: ", body: "We will come back to you asap." }
    @contact = Contact.create(contact_params)
    
    SupportMailer.delay.contact(@contact.id)     

    redirect_to :back
  end
  
private


  def contact_params
    params.require(:contact).permit(:email, :title, :body)
  end
end
