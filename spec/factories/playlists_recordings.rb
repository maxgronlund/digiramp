# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :playlists_recording, :class => 'PlaylistsRecordings' do
    playlist ""
    recording nil
  end
end
