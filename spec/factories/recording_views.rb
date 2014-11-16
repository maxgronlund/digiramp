# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recording_view do
    user nil
    recording nil
    account nil
  end
end
