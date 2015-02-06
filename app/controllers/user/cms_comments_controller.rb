class User::CmsCommentsController < ApplicationController
  before_action :set_cms_comment, only: [:show, :edit, :update, :destroy]
  before_filter :access_user

  def edit
    
  end
  
  def update
    cms_section           = @cms_comment.cms_section
    cms_section.position = params[:cms_comment][:position]
    cms_section.save!
    params[:cms_comment].delete :position
    @cms_comment.update(cms_comment_params) unless params[:cms_comment] == {}

    redirect_to user_user_cms_page_path(@user, @cms_comment.cms_section.cms_page)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_comment
      @cms_comment = CmsComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_comment_params
      params.require(:cms_comment).permit(:position)
    end
end
