# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follower_event do
    user nil
    body "MyText"
    event_type "MyString"
    url "MyString"
  end
end
