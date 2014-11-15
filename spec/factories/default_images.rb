# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :default_image do
    recording_artwork "MyString"
    user_avatar "MyString"
    company_logo "MyString"
  end
end
