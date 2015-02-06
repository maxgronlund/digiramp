class User::CmsSectionsController < ApplicationController
  before_action :set_cms_section, only: [:show, :edit, :update, :destroy]
  before_filter :access_user
  # GET /cms_sections
  # GET /cms_sections.json
  def index
    @cms_sections = CmsSection.all
  end

  # GET /cms_sections/1
  # GET /cms_sections/1.json
  def show
  end

  # GET /cms_sections/new
  def new
    @cms_section = CmsSection.new
  end

  # GET /cms_sections/1/edit
  def edit
  end

  # POST /cms_sections
  # POST /cms_sections.json
  def create
    @cms_section = CmsSection.new(cms_section_params)

    case @cms_section.cms_type
      
    when 'Banner'
      @cms_banner = CmsBanner.create
      @cms_section.cms_module_id    = @cms_banner.id
      @cms_section.cms_module_type  = @cms_banner.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_banner_path(@user, @cms_banner)
    
    
    when 'Recording'
      @cms_recording = CmsRecording.create
      @cms_section.cms_module_id    = @cms_recording.id
      @cms_section.cms_module_type  = @cms_recording.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_recording_path(@user, @cms_recording)
      
    when 'Horizontal links'
      @cms_horizontal_link = CmsHorizontalLink.create
      @cms_section.cms_module_id    = @cms_horizontal_link.id
      @cms_section.cms_module_type  = @cms_horizontal_link.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_horizontal_link_path(@user, @cms_horizontal_link)
      
    when 'Vertical links'
      @cms_vertical_link = CmsVerticalLink.create
      @cms_section.cms_module_id    = @cms_vertical_link.id
      @cms_section.cms_module_type  = @cms_vertical_link.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_vertical_link_path(@user, @cms_vertical_link)
      
    when 'Playlist link'
      @cms_playlist_link = CmsPlaylistLink.create
      @cms_section.cms_module_id    = @cms_playlist_link.id
      @cms_section.cms_module_type  = @cms_playlist_link.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_playlist_link_path(@user, @cms_playlist_link)
      
    when 'Video snippet'
      @cms_video = CmsVideo.create
      @cms_section.cms_module_id    = @cms_video.id
      @cms_section.cms_module_type  = @cms_video.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_video_path(@user, @cms_video)
      
    when 'Text'
      @cms_text = CmsText.create
      @cms_section.cms_module_id    = @cms_text.id
      @cms_section.cms_module_type  = @cms_text.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_text_path(@user, @cms_text)
    end
  end

  # PATCH/PUT /cms_sections/1
  # PATCH/PUT /cms_sections/1.json
  def update
    respond_to do |format|
      if @cms_section.update(cms_section_params)
        format.html { redirect_to @cms_section, notice: 'Cms section was successfully updated.' }
        format.json { render :show, status: :ok, location: @cms_section }
      else
        format.html { render :edit }
        format.json { render json: @cms_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms_sections/1
  # DELETE /cms_sections/1.json
  def destroy
    @section_id = @cms_section.id
    @cms_section.destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_section
      @cms_section = CmsSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_section_params
      params.require(:cms_section).permit!
    end
end