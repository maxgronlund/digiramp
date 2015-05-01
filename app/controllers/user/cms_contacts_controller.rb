class User::CmsContactsController < ApplicationController
  before_action :set_cms_contact, only: [ :edit, :update]

  before_action :access_user

  def edit
  end
  
  def update
    cms_section           = @cms_contact.cms_section
    #cms_section.position = params[:cms_contact][:position]
    cms_section.save!
    #params[:cms_text].delete :position
    @cms_contact.update(cms_contact_params) unless params[:cms_contact] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_contact.cms_section.cms_page)
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_contact
      @cms_contact = CmsContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_contact_params
      params.require(:cms_contact).permit!
    end
end
