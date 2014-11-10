# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :share_recording_with_email do
    user nil
    recording nil
    recipients "MyText"
    title "MyString"
    message "MyText"
  end
end
