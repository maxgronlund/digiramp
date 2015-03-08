class Account::RecordingDocumentsController < ApplicationController
  
  include RecordingsHelper
  include AccountsHelper
  before_filter :access_account
  before_filter :read_recording
  
  def index
    
    @files = Attachment.where(attachable_type: 'Recording', attachable_id: @recording.id, file_type: 'document')
    
  end

  def new
    @attachments = Attachment.new
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
