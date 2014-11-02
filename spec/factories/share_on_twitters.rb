# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :share_on_twitter do
    user nil
    recording nil
    message "MyText"
  end
end
