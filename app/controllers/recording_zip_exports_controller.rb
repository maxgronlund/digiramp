require 'rubygems'
require 'zip'
require "open-uri"
 
 
class RecordingZipExportsController < ApplicationController
  def show
    
    logger.info '======================== ZIPPING ===================================='
    @recording = Recording.find(params[:id])
    @recording.zip
    render nothing: true
        
  end
end


