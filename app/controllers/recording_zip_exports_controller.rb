require 'rubygems'
require 'zip'
require "open-uri"
 
 
class RecordingZipExportsController < ApplicationController
  def show
    

    
    @recording = Recording.cached_find(params[:id])
    @recording.zip
    
  
    
    
    render nothing: true
    
               
  end
end


