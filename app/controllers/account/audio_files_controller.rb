class Account::AudioFilesController < ApplicationController
  include ActionView::Helpers::TextHelper
  include AccountsHelper
  before_action :access_account
  
  include Transloadit::Rails::ParamsDecoder
  
  def index
    forbidden current_account_user.read_recording?
    @recordings = @account.recordings.where(in_bucket: true)
    
  end
  
  def show
    
  end
  
  def new
    forbidden current_account_user.create_recording?
  end
  
  def create
   
    forbidden urrent_account_user.create_recording?
    
    begin
      result = TransloaditRecordingsParser.parse params[:transloadit],  @account.id, true, current_account_user.user_id

      
      # success mesage
      unless result[:recordings].size == 0
        flash[:info]      = "#{pluralize(result[:recordings].size, "File")} uploaded" 
      end
      # error messages
      unless result[:errors].size == 0
        errors     = ''
        nr_errors = 0
        result[:errors].each do |error|
          nr_errors += 1
          errors << error + '<br>'
        end
        flash[:danger]    = errors 
      end
      
      
      
      redirect_to account_account_recordings_bucket_index_path(@account)
    rescue
      flash[:danger]      = "Unable to create Recording Please check if you selected a valid file" 
      redirect_to new_account_account_audio_file_path(@account, @common_work )
    end
    
  end
  
  def edit
    forbidden urrent_account_user.edit_recording?
    @recording            = Recording.cached_find(params[:id])
  end

  
  def destroy
    
  end

  
end
