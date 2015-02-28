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
    
    
    params[:cms_section][:position] = get_next_possition
    
    @cms_section = CmsSection.new(cms_section_params)

    case @cms_section.cms_type
      
    when 'Banner'
      @cms_banner = CmsBanner.create
      @cms_section.cms_module_id    = @cms_banner.id
      @cms_section.cms_module_type  = @cms_banner.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_banner_path(@user, @cms_banner)
      
    when 'Contact'
      @cms_contact = CmsContact.create
      @cms_section.cms_module_id    = @cms_contact.id
      @cms_section.cms_module_type  = @cms_contact.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_page_path(@user, @cms_contact.cms_section.cms_page)
      
    when 'Comment'
      @cms_comment = CmsComment.create
      @cms_section.cms_module_id    = @cms_comment.id
      @cms_section.cms_module_type  = @cms_comment.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_page_path(@user, @cms_comment.cms_section.cms_page)
      
    when 'Horizontal links'
      @cms_horizontal_link = CmsHorizontalLink.create
      @cms_section.cms_module_id    = @cms_horizontal_link.id
      @cms_section.cms_module_type  = @cms_horizontal_link.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_page_path(@user, @cms_horizontal_link.cms_section.cms_page)

      
    when 'Image'
      @cms_image = CmsImage.create
      @cms_section.cms_module_id    = @cms_image.id
      @cms_section.cms_module_type  = @cms_image.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_image_path(@user, @cms_image)
      
    when 'Menu bar'
      @cms_navigation_bar            = CmsNavigationBar.create
      @cms_section.cms_module_id    = @cms_navigation_bar.id
      @cms_section.cms_module_type  = @cms_navigation_bar.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_navigation_bar_path(@user, @cms_navigation_bar)
      
    when 'Video snippet'
      @cms_video                    = CmsVideo.create
      @cms_section.cms_module_id    = @cms_video.id
      @cms_section.cms_module_type  = @cms_video.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_video_path(@user, @cms_video)
    
    
    when 'Recording'
      @cms_recording = CmsRecording.create
      @cms_section.cms_module_id    = @cms_recording.id
      @cms_section.cms_module_type  = @cms_recording.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_recording_path(@user, @cms_recording)
      
    when 'Playlist link'
      @cms_playlist_link            = CmsPlaylistLink.create
      @cms_section.cms_module_id    = @cms_playlist_link.id
      @cms_section.cms_module_type  = @cms_playlist_link.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_playlist_link_path(@user, @cms_playlist_link)
      
    when 'Playlist'
      @cms_playlist                 = CmsPlaylist.create
      @cms_section.cms_module_id    = @cms_playlist.id
      @cms_section.cms_module_type  = @cms_playlist.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_playlist_path(@user, @cms_playlist)
      
    when 'Profile'
      @cms_profile                  = CmsProfile.create
      @cms_section.cms_module_id    = @cms_profile.id
      @cms_section.cms_module_type  = @cms_profile.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_profile_path(@user, @cms_profile)
      
    when 'Social links'
      @cms_social_link = CmsSocialLink.create()
      @cms_section.cms_module_id    = @cms_social_link.id
      @cms_section.cms_module_type  = @cms_social_link.class.name
      
      @cms_section.save!
      redirect_to edit_user_user_cms_page_path(@user, @cms_social_link.cms_section.cms_page)
      
    when 'Text'
      @cms_text = CmsText.create
      @cms_section.cms_module_id    = @cms_text.id
      @cms_section.cms_module_type  = @cms_text.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_text_path(@user, @cms_text)

    when 'Vertical links'
      @cms_vertical_link = CmsVerticalLink.create
      @cms_section.cms_module_id    = @cms_vertical_link.id
      @cms_section.cms_module_type  = @cms_vertical_link.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_page_path(@user, @cms_vertical_link.cms_section.cms_page)
      
    when 'Video snippet'
      @cms_video                    = CmsVideo.create
      @cms_section.cms_module_id    = @cms_video.id
      @cms_section.cms_module_type  = @cms_video.class.name
      @cms_section.save!
      redirect_to edit_user_user_cms_video_path(@user, @cms_video)
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
    
    
    
    cms_page  = @cms_section.cms_page
    column_nr = @cms_section.column_nr
    @cms_section.destroy
    
    # cleanup
    cms_page.cms_sections.order(:position).where(column_nr: column_nr).each_with_index do |section, index|
      section.position = index
      section.save!
    end

    
  end

  private
    # always add new sections at the bottom 
    def get_next_possition
      cms_page = CmsPage.cached_find(params[:cms_section][:cms_page_id])
      if last_cms_sections = cms_page.cms_sections.order(:position).where(column_nr: params[:cms_section][:column_nr]).last
        if last_cms_sections.position.nil?
          return fix_positions_for( cms_page )
        else
          return last_cms_sections.position + 1
        end
      end
      0
    end
    
    def fix_positions_for cms_page
      position = 0
      cms_page.cms_sections.order(:position).each_with_index do |cms_section, index|
        cms_section.position = index
        cms_section.save!
        position = index
      end
      position + 1
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_section
      @cms_section = CmsSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_section_params
      params.require(:cms_section).permit!
    end
end
