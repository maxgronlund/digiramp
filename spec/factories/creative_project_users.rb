FactoryGirl.define do
  factory :creative_project_user do
    creative_project nil
user nil
approved_by_project_manager false
approved_by_user false
locked false
email "MyString"
created_by 1
writers false
composers false
musicians false
dancers false
live_performers false
producers false
studio_facilities false
financial_services false
legal_services false
publichers false
remixers false
audio_engineers false
video_artists false
graphic_artists false
other false
  end

end
