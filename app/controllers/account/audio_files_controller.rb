class Account::AudioFilesController < ApplicationController
  include ActionView::Helpers::TextHelper
  include AccountsHelper
  before_filter :access_account
  
  include Transloadit::Rails::ParamsDecoder
  
  def index
    @recordings = @account.recordings.where(in_bucket: true)
    
  end
  
  def show
    
  end
  
  def new
    forbidden unless current_account_user.create_recording?
  end
  
  def create
   
    forbidden unless current_account_user.create_recording?
    
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
    @recording            = Recording.cached_find(params[:id])

  end

  
  def destroy
    
  end

  
end
