# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :connection do
    user nil
    connection_id 1
    approved false
    message "MyText"
  end
end
