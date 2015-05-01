class Admin::ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :admins_only
 

  def index
    @contacts = Contact.all
  end

  def show
    
  end


  def edit
  end


  def destroy
    @contact.destroy
    redirect_to admin_contracts_path
    #respond_to do |format|
    #  format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:email, :title, :body)
    end
end
