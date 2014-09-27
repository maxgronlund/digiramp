# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :playlist_recording, :class => 'PlaylistRecordings' do
    playlist_id ""
    recording_id 1
  end
end
