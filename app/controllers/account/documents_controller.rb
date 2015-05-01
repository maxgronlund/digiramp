class Account::DocumentsController < ApplicationController
  
  include AccountsHelper
  before_action :access_account
  
  
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
    redirect_to :back
  end
end