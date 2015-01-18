class UpdateHttpUrlsOnRecordings < ActiveRecord::Migration
  def change
    Recording.find_each do |rec|
      rec.mp3             = rec.mp3.sub('http://digiramp.s3.amazonaws.com/', 'https://digiramp.s3.amazonaws.com/')             unless rec.mp3.to_s == ''
      rec.thumbnail       = rec.thumbnail.sub('http://digiramp.s3.amazonaws.com/', 'https://digiramp.s3.amazonaws.com/')       unless rec.thumbnail.to_s == ''
      rec.waveform        = rec.waveform.sub('http://digiramp.s3.amazonaws.com/', 'https://digiramp.s3.amazonaws.com/')        unless rec.waveform.to_s == ''
      rec.cover_art       = rec.cover_art.sub('http://digiramp.s3.amazonaws.com/', 'https://digiramp.s3.amazonaws.com/')       unless rec.cover_art.to_s == ''
      rec.original_file   = rec.original_file.sub('http://digiramp.s3.amazonaws.com/', 'https://digiramp.s3.amazonaws.com/')   unless rec.original_file.to_s == ''
      rec.zipp            = rec.zipp.sub('http://digiramp.s3.amazonaws.com/', 'https://digiramp.s3.amazonaws.com/')            unless rec.zipp.to_s == ''
      rec.save
    end
  end
end
