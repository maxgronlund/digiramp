class UploadRecordingsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def new
    @recording = Recording.new
  end

  def edit
  end
end
