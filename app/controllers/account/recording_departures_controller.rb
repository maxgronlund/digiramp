class Account::RecordingDeparturesController < ApplicationController
  
  include AccountsHelper
  before_filter :get_account_account
  
  def index
    forbidden unless current_account_user && current_account_user.create_recording
    @user = current_user
  end

  def create
    #ap 
    if params[:account][:transfer_codes]
      params[:account][:transfer_codes].split(',').each do |transfer_code|
        transfer_code = transfer_code.strip.gsub(/\s+/, ' ')
        if recording = Recording.where(transfer_code: transfer_code).first
          if recording.transferable
            recording.account_id    = @account.id
            recording.user_id       = @account.user_id
            recording.transferable  = false
            recording.transfer_code = UUIDTools::UUID.timestamp_create().to_s
            recording.save
          end
        end
      end
    end
    redirect_to :back
  end
end
