class DownloadController < ApplicationController
  #include AccountsHelper
  #before_filter :access_to_account
  
  def image_file
    
    
    @image_file = ImageFile.find(params[:image_file])
    puts '----------------------------------------------------------'
    puts @image_file.file
    puts @image_file.title
    puts '----------------------------------------------------------'
    data = open("#{@image_file.file}") 
    mime = @image_file.mime || 'image/jpeg'
    send_data data.read, filename: @image_file.title, type: mime, stream: 'true', buffer_size: '4096'  
    
    #puts @image_file.file.inspect
    #
    ##redirect_to :back
    #
    #
    #cookies['fileDownload'] = 'true'
    #
    #send_file "http://digiramp.s3.amazonaws.com/1d/1e80c0ecde11e389bc5963b596bb3c/140430134852-china-new-hotels-dawang-mountain-resort-horizontal-large-gallery.jpg",
    #  :filename => '140430134852-china-new-hotels-dawang-mountain-resort-horizontal-large-gallery.jpg',
    #  :type => 'image',
    #  :x_sendfile => true
    #  
    #
  end

  
end
