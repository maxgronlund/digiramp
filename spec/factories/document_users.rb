FactoryGirl.define do
  factory :document_user do
    document nil
user nil
account nil
can_edit false
should_sign false
email "MyString"
signature "MyString"
signature_image "MyString"
status 1
  end

end
