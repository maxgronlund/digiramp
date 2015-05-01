class Account::RecordingDocumentsController < ApplicationController
  
  include RecordingsHelper
  include AccountsHelper
  before_action :access_account
  before_action :read_recording
  
  def index
    forbidden unless current_account_user.can_manage_assets?
    @files = Attachment.where(attachable_type: 'Recording', attachable_id: @recording.id, file_type: 'document')
    @user  = current_user
  end

  def new
    forbidden unless current_account_user.can_manage_assets?
    @attachments = Attachment.new
    @user        = current_user
  end

  def create
    Attachment.create(attachment_params)
    redirect_to account_account_recording_recording_documents_path(@account, @recording)
  end

  def destroy
  end
  
  private
  
  def attachment_params
    params.require(:attachment).permit!
  end
end
