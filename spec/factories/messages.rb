# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    recipient_id 1
    sender_id 1
    subject "MyString"
    body "MyText"
    recipient_removed false
    sender_removed false
    subjebtable_id 1
    subjectable_type "MyString"
  end
end
