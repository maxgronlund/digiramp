class UploadRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  include AccountsHelper
  before_filter :access_to_account

  def new
    @recording        = Recording.new
  end
  
  # called when an  import is completed
  def create
    @import_batch         = TransloaditParser.parse_recordings( params[:transloadit], @account.id )
    flash[:info]          = { title: "SUCCESS: ", body: "Import completed" }
    redirect_to account_import_batch_path(@account,   @import_batch)
  end
  
  def extrace_tags_for genre_string
    genres = genre_string.split(',')
  end
  
  def index
    
  end
  

  def edit
    @recording              = Recording.cached_find(params[:id])
    @common_work            = CommonWork.cached_find(params[:common_work_id])
  end
  
  def update
    flash[:info]            = { title: "SUCCESS: ", body: "Audio file uploaded" }
    @recording              = Recording.cached_find(params[:id])
    @common_work            = CommonWork.cached_find(params[:common_work_id])
    transloadets            = TransloaditParser.update(@recording, params[:transloadit] )
    redirect_to edit_account_common_work_recording_path(@account, @common_work, @recording )
  end
  
  def set_permission_keys
    
    #account           = @import_batch.account
    #account_user_ids  = [account.user_id]
    #
    #account_user_ids  += AccountUser.where(account_id: account.id, role: 'Administrator').pluck(:id) || []
    #
    #@import_batch.recordings.each do |recording|
    #  recording.create_recording_ids             = account_user_ids
    #  recording.read_recording_ids               = account_user_ids
    #  recording.update_recording_ids             = account_user_ids
    #  recording.delete_recording_ids             = account_user_ids
    #  recording.create_recording_ipis_ids        = account_user_ids
    #  recording.read_recording_ipis_ids          = account_user_ids
    #  recording.update_recording_ipis_ids        = account_user_ids
    #  recording.delete_recording_ipis_ids        = account_user_ids
    #  recording.create_files_ids                 = account_user_ids
    #  recording.read_files_ids                   = account_user_ids
    #  recording.update_files_ids                 = account_user_ids
    #  recording.delete_files_ids                 = account_user_ids
    #  recording.create_legal_documents_ids       = account_user_ids
    #  recording.read_legal_documents_ids         = account_user_ids
    #  recording.update_legal_documents_ids       = account_user_ids
    #  recording.delete_legal_documents_ids       = account_user_ids
    #  recording.create_financial_documents_ids   = account_user_ids
    #  recording.read_financial_documents_ids     = account_user_ids
    #  recording.update_financial_documents_ids   = account_user_ids
    #  recording.delete_financial_documents_ids   = account_user_ids
    #  recording.read_common_works_ids            = account_user_ids
    #  recording.update_common_works_ids          = account_user_ids
    #  recording.create_common_work_ipis_ids      = account_user_ids 
    #  recording.read_common_work_ipis_ids        = account_user_ids 
    #  recording.update_common_work_ipis_ids      = account_user_ids
    #  recording.delete_common_work_ipis_ids      = account_user_ids
    #  recording.save!
    #end
    
  end
  

end
