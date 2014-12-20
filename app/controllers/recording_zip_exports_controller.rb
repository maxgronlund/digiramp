require 'rubygems'
require 'zip'
require "open-uri"
 
 
class RecordingZipExportsController < ApplicationController
  def show
    
    puts '============= RecordingZipExportsController # show ============================================'
    ap params
    @recording = Recording.cached_find(params[:id])
    ap @recording
    @recording.zip
    
  
    
    
    render nothing: true
    
               
  end
end


