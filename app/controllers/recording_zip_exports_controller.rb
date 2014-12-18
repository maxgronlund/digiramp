require 'rubygems'
require 'zip'
require "open-uri"
 
 
class RecordingZipExportsController < ApplicationController
  def show
    

    
    @recording = Recording.cached_find(params[:id])
    @recording.zip
    
    #folder = UUIDTools::UUID.timestamp_create().to_s
    #
    #new_dir = Dir.mkdir( Rails.root.join("public", "uploads", "recordings", "zip", folder) )
    #
    #temp_file = Tempfile.new("recording-zip-#{UUIDTools::UUID.timestamp_create().to_s}")
    #  Zip::OutputStream.open(temp_file.path) do |z|
    #    title = @recording.original_file_name
    #    z.put_next_entry("#{@recording.title}/#{title}")
    #    url1_data = open(@recording.mp3)
    #    z.print IO.read(url1_data)
    #  end
    #  
    #  send_file temp_file.path, :type => 'application/zip',
    #                    :disposition => 'attachment',
    #                    :filename => "#{@recording.title}.zip"
    #                    
    #                    
    #
    #  
    #  
    #  file = File.open(Rails.root.join("public", "uploads", "recordings", "zip", folder ,"#{@recording.title}.zip"), "w+b")
    #  file.write(temp_file.read)
    #  
    #
    #  @recording.zipp =  "uploads/recordings/zip/" + folder + '/' +  @recording.title + ".zip"
    #  @recording.save
    #  
    #temp_file.close
    
    
    render nothing: true
    
               
  end
end


