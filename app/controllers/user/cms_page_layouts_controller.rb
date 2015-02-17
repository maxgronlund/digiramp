class User::CmsPageLayoutsController < ApplicationController
  before_action :set_cms_page, only: [:edit, :update]
  before_filter :access_user
  
  def edit
    
  end
  
  def update
    @cms_page.update(cms_page_params)
    redirect_to edit_user_user_cms_page_path(@user, @cms_page)
  end
  
private
  def set_cms_page
    @cms_page = CmsPage.find(params[:id])
  end

  def cms_page_params
    params.require(:cms_page).permit!
  end
end
