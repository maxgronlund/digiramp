FactoryGirl.define do
  factory :playlist_email do
    emails "MyText"
title "MyString"
body "MyText"
attach_files false
playlist nil
user nil
account nil
  end

end
