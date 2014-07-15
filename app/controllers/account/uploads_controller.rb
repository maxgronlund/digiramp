class Account::UploadsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include ActionView::Helpers::TextHelper
  include AccountsHelper
  before_filter :access_account
  
  
  def index
  end
  
  def common_works
    forbidden unless current_account_user.create_common_work?
  end
  
  # audio files
  def audio_files
    forbidden unless current_account_user.create_recording?
  end
  
  def audio_files_new
    #redirect_to :back
  end
  
  def audio_files_create
    
    forbidden unless current_account_user.create_recording?
    
    #ap params[:transloadit]

    result = TransloaditRecordingsParser.parse( params[:transloadit],  @account.id, false)
    
    # success 
    unless result[:recordings].size == 0
      
      result[:recordings].each do |recording|

        
        common_work = CommonWork.create(account_id: recording.account_id, title: recording.title, lyrics: recording.lyrics)
        recording.common_work_id = common_work.id
        recording.save
        recording.common_work.update_completeness

      end
      
      flash[:info]      = { title: "Succes", body: "#{pluralize(result[:recordings].size, "File")} uploaded" }
    end
    # error messages
    unless result[:errors].size == 0
      errors     = ''
      nr_errors = 0
      result[:errors].each do |error|
        nr_errors += 1
        errors << error + '<br>'
      end
      flash[:danger]    = { title: "Errors", body: errors }
    end
    
    
    
    
    
    redirect_to account_account_common_works_path(@account)


  end
end
