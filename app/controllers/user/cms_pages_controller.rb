class User::CmsPagesController < ApplicationController
  before_action :set_cms_page, only: [:show, :edit, :update, :destroy]
  before_filter :access_user

  # GET /cms_pages
  # GET /cms_pages.json
  def index
    @cms_pages = CmsPage.all
  end

  # GET /cms_pages/1
  # GET /cms_pages/1.json
  def show
    
  end

  # GET /cms_pages/new
  def new
    @cms_page = CmsPage.new
  end

  # GET /cms_pages/1/edit
  def edit
  end

  # POST /cms_pages
  # POST /cms_pages.json
  def create
    ap params
    @cms_page = CmsPage.create(cms_page_params)
    redirect_to user_user_cms_pages_path(@user)
    #respond_to do |format|
    #  if @cms_page.save
    #    format.html { redirect_to @cms_page, notice: 'Cms page was successfully created.' }
    #    format.json { render :show, status: :created, location: @cms_page }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @cms_page.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /cms_pages/1
  # PATCH/PUT /cms_pages/1.json
  def update
    @cms_page.update(cms_page_params)
    redirect_to user_user_cms_pages_path(@user)
    #respond_to do |format|
    #  if @cms_page.update(cms_page_params)
    #    format.html { redirect_to @cms_page, notice: 'Cms page was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @cms_page }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @cms_page.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /cms_pages/1
  # DELETE /cms_pages/1.json
  def destroy
    @cms_page.destroy
    redirect_to user_user_cms_pages_path(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_page
      @cms_page = CmsPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_page_params
      params.require(:cms_page).permit!
    end
end
