class CmsPagesController < ApplicationController
  before_action :set_cms_page, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:show]
  # GET /cms_pages
  # GET /cms_pages.json
  def index
    @cms_pages = CmsPage.all
  end

  # GET /cms_pages/1
  # GET /cms_pages/1.json
  protect_from_forgery :except => :show
  def show
    return not_found unless @user
    @body_color = "#15141C"
    @image_url  = "https://digiramp.com/uploads/raw_image/image/24/music-enthusiasts.jpg"
    
    @user_activities = @user.user_activities.order('id desc').page(params[:page]).per(4)
    @playlists       = current_user.playlists if current_user
    @edit_page       = @user.permits?( current_user)
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
    @cms_page = CmsPage.new(cms_page_params)

    respond_to do |format|
      if @cms_page.save
        format.html { redirect_to @cms_page, notice: 'Cms page was successfully created.' }
        format.json { render :show, status: :created, location: @cms_page }
      else
        format.html { render :new }
        format.json { render json: @cms_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cms_pages/1
  # PATCH/PUT /cms_pages/1.json
  def update
    respond_to do |format|
      if @cms_page.update(cms_page_params)
        format.html { redirect_to @cms_page, notice: 'Cms page was successfully updated.' }
        format.json { render :show, status: :ok, location: @cms_page }
      else
        format.html { render :edit }
        format.json { render json: @cms_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms_pages/1
  # DELETE /cms_pages/1.json
  def destroy
    @cms_page.destroy
    respond_to do |format|
      format.html { redirect_to cms_pages_url, notice: 'Cms page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_page
      begin
        @cms_page = CmsPage.cached_find(params[:id])
      rescue
        not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_page_params
      params.require(:cms_page).permit(:user_id, :title)
    end
    
    def find_user
      begin
        @user = User.cached_find(params[:user_id])
        # If an old id or a numeric id was used to find the record, then
        # the request path will not match the post_path, and we should do
        # a 301 redirect that uses the current friendly id.
        #if request.path != user_path(@user)
        #  return redirect_to @user, :status => :moved_permanently
        #end
      rescue
        not_found
      end
    end
end
