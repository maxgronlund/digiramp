class SharedRecordingArtworksController < ApplicationController
  include RecordingsHelper
  include SharedCatalogsHelper
  
  before_filter :access_user, only:[:show]
  before_filter :read_catalog, only:[:show]
  before_filter :read_recording, only:[:show]
  
  
  def show

  end
end
