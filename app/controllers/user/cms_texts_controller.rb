class User::CmsTextsController < ApplicationController
  before_action :set_cms_text, only: [:show, :edit, :update, :destroy]

  before_filter :access_user

  def edit
  end
  
  def update
    cms_section           = @cms_text.cms_section
    cms_section.position = params[:cms_text][:position]
    cms_section.save!
    params[:cms_text].delete :position
    @cms_text.update(cms_text_params) unless params[:cms_text] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_text.cms_section.cms_page)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_text
      @cms_text = CmsText.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_text_params
      params.require(:cms_text).permit(:position, :title, :body)
    end
end
