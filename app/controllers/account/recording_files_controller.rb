class Account::RecordingFilesController < ApplicationController
  
  include RecordingsHelper
  include AccountsHelper
  before_action :access_account
  before_action :read_recording
  
  def index
    forbidden unless current_account_user.read_file?   
    @user  = current_user
    @files = Attachment.where(attachable_type: 'Recording', attachable_id: @recording.id, file_type: 'file')
  end

  def new
    forbidden unless current_account_user.create_file?   
    @user  = current_user
    @attachments = Attachment.new
  end

  def create
    forbidden unless current_account_user.create_file?   
    @user  = current_user
    Attachment.create(attachment_params)
    redirect_to account_account_recording_recording_files_path(@account, @recording)
  end

  def destroy
  end
  
  private
  
  def attachment_params
    params.require(:attachment).permit!
  end
end
