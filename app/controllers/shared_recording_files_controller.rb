class SharedRecordingFilesController < ApplicationController
  include RecordingsHelper
  include SharedCatalogsHelper
  
  before_action :access_user, only:[:show]
  before_action :read_catalog, only:[:show]
  before_action :read_recording, only:[:show]
  
  
  def show

  end
end
