class User::CmsPagesController < ApplicationController
  before_action :set_cms_page, only: [:show, :edit, :update, :destroy]
  before_filter :access_user

  def index
    @cms_pages = CmsPage.all
  end

  def show
    
  end

  def new
    @cms_page = CmsPage.new
  end

  def edit
  end

  def create
    ap params
    @cms_page = CmsPage.create(cms_page_params)
    redirect_to user_user_cms_pages_path(@user)

  end

  def update
    @cms_page.update(cms_page_params)
    redirect_to edit_user_user_cms_page_path(@user, @cms_page)

  end

  def destroy
    @cms_page.destroy
    redirect_to user_user_cms_pages_path(@user)
  end

  private
    def set_cms_page
      @cms_page = CmsPage.find(params[:id])
    end

    def cms_page_params
      params.require(:cms_page).permit!
    end
end
