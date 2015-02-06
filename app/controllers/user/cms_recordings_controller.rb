class User::CmsRecordingsController < ApplicationController
  before_action :set_cms_recording, only: [:show, :edit, :update, :destroy]
  before_filter :access_user

  def edit
  end
  
  def update
    cms_section           = @cms_recording.cms_section
    cms_section.position = params[:cms_recording][:position]
    cms_section.save!
    params[:cms_recording].delete :position
    @cms_recording.update(cms_recording_params) unless params[:cms_recording] == {}

    redirect_to user_user_cms_page_path(@user, @cms_recording.cms_section.cms_page)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_recording
      @cms_recording = CmsRecording.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_recording_params
      params.require(:cms_recording).permit!
    end
end
