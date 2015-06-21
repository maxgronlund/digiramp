class User::CmsSectionsController < ApplicationController
  before_action :set_cms_section, only: [:show, :edit, :update, :destroy]
  before_action :access_user
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
      banner
    when 'Contact'
      contact
    when 'Comment'
      comment
    when 'Horizontal links'
      horizontal_links
    when 'Image'
      image
    when 'Menu bar'
      menu_bar
    when 'Video snippet'
      video_snippet
    when 'Recording'
      recording
    when 'Playlist link'
      playlist_link
    when 'Playlist'
      playlist
    when 'Profile'
      profile
    when 'Social links'
      social_links
    when 'Text'
      text
    #when 'Activities'
    #   activities
    when 'Vertical links'
      vertical_links
    when 'Video snippet'
      video_snippet
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
    params.require(:cms_section).permit( :cms_page_id,
                                         :position,
                                         :column_nr,
                                         :cms_type,
                                         :cms_module_id,
                                         :cms_module_type
                                        )
  end

  def banner
    @cms_banner = create_section( CmsBanner.create )
    redirect_to edit_user_user_cms_banner_path(@user, @cms_banner)
  end
  
  def contact
    @cms_contact = create_section( CmsContact.create )
    redirect_to edit_user_user_cms_page_path(@user, @cms_contact.cms_section.cms_page)
  end
  
  def comment
    @cms_comment = create_section( CmsComment.create )
    redirect_to edit_user_user_cms_page_path(@user, @cms_comment.cms_section.cms_page)
  end
  
  def horizontal_links
    @cms_horizontal_link = create_section( CmsHorizontalLink.create)
    redirect_to edit_user_user_cms_page_path(@user, @cms_horizontal_link.cms_section.cms_page)
  end
  
  def image
    @cms_image = create_section( CmsImage.create )
    redirect_to edit_user_user_cms_image_path(@user, @cms_image)
  end
  
  def menu_bar
    @cms_navigation_bar            = create_section( CmsNavigationBar.create )
    redirect_to edit_user_user_cms_navigation_bar_path(@user, @cms_navigation_bar)
  end
  
  def recording
    @cms_recording = create_section( CmsRecording.create )
    redirect_to edit_user_user_cms_recording_path(@user, @cms_recording)
  end
  
  def playlist_link
    @cms_playlist_link = create_section( CmsPlaylistLink.create )
    redirect_to edit_user_user_cms_playlist_link_path(@user, @cms_playlist_link)
  end
  
  def playlist
    @cms_playlist = create_section( CmsPlaylist.create)
    redirect_to edit_user_user_cms_playlist_path(@user, @cms_playlist)
  end
  
  def profile
    @cms_profile = create_section( CmsProfile.create)
    redirect_to edit_user_user_cms_page_path(@user, @cms_profile.cms_section.cms_page)
  end
  
  def social_links
    @cms_social_link = create_section( CmsSocialLink.create)
    redirect_to edit_user_user_cms_page_path(@user, @cms_social_link.cms_section.cms_page)
  end
  
  def text
    @cms_text = create_section( CmsText.create )
    redirect_to edit_user_user_cms_text_path(@user, @cms_text)
  end
  
  def activities
    @cms_user_activities = create_section( CmsUserActivity.create(user_id: @user.id))
    redirect_to edit_user_user_cms_page_path(@user, @cms_user_activities.cms_section.cms_page)
  end
  
  def vertical_links
    @cms_vertical_link = create_section( CmsVerticalLink.create )
    redirect_to edit_user_user_cms_page_path(@user, @cms_vertical_link.cms_section.cms_page)
  end
  
  def video_snippet
    @cms_video = create_section( CmsVideo.create )
    redirect_to edit_user_user_cms_video_path(@user, @cms_video)
  end
  
  def create_section section
    @cms_section.cms_module_id    = section.id
    @cms_section.cms_module_type  = section.class.name
    @cms_section.save!
    section
  end
  
end
