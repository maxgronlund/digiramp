class Account::RecordingLegalDocumentsController < ApplicationController
  
  include RecordingsHelper
  include AccountsHelper
  before_action :access_account
  before_action :read_recording
  
  def index
    forbidden unless current_account_user.read_legal_document?
    @files = Attachment.where(attachable_type: 'Recording', attachable_id: @recording.id, file_type: 'legal_document')
    @user  = current_user
  end

  def new
    forbidden unless current_account_user.create_legal_document?
    @attachments = Attachment.new
    @user  = current_user
  end

  def create
    forbidden unless current_account_user.create_legal_document?
    Attachment.create(attachment_params)
    redirect_to account_account_recording_recording_legal_documants_path(@account, @recording)
    @user  = current_user
  end

  def destroy
  end
  
  private
  
  def attachment_params
    params.require(:attachment).permit!
  end
end
