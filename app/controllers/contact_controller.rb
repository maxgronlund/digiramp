class ContactController < ApplicationController
  
  def index
    @contact = Contact.new()
  end
  
  def create
    if EmailSanitizer.validate( params[:contact][:email])
      flash[:info] = "Contact request send: We will come back to you asap." 
      @contact = Contact.create(contact_params)
      ContactMailer.delay.contace_received(@contact.id)   
      redirect_to contact_index_path
    else
      flash[:danger] = "Please check the email." 
      redirect_to contact_index_path(error_in_form: true, title: params[:contact][:title], body: params[:contact][:body], email: params[:contact][:email])
    end
    
    
    
  end
  private
  def contact_params
    params.require(:contact).permit(:email, :title, :body, :contact_subject)
  end
end
