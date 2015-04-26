class SupportsController < ApplicationController
  def index
    
    #forbidden unless current_user
    #@user = current_user
    if params[:error_in_form]
      @contact = Contact.new(title: params[:title], body: params[:body], email: params[:email] )
    else
      @contact = Contact.new
    end
  end
  
  def create
    
    if EmailSanitizer.validate( params[:contact][:email])
      flash[:info] = "Message send: We will come back to you asap." 
      @contact = Contact.create(contact_params)
      SupportMailer.delay.contact(@contact.id)   
      redirect_to support_index_path
    else
      flash[:danger] = "Please check the email." 
      redirect_to support_index_path(error_in_form: true, title: params[:contact][:title], body: params[:contact][:body], email: params[:contact][:email])
    end
    

    
  end
  
private


  def contact_params
    params.require(:contact).permit(:email, :title, :body)
  end
end
