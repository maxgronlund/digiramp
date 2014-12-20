class ZipRecordingsWorker
  include Sidekiq::Worker
  
  def perform()
    puts '------------- start '
    #if recording = Recording.where(zipp: nil).first
    #  recording.zip
    #  
    #end
    count = 0
    if recordings = Recording.where(zipp: nil).first(20)
      recordings.each do |recording|
        
        recording.zip
        count += 1
        puts "Done: #{count}"
      end
    end
    puts '------------- done done '
    
  end
end