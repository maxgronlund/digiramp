

FactoryGirl.define do
  
  user_name = Faker::Name.name
  slug = user_name.underscore  
  
  factory :user do |f|
    #sequence(:user_name) { |n| "foo#{n}" }
    #f.name        Faker::Name.first_name
    f.user_name   user_name
    f.email       Faker::Internet.email
    f.password    Faker::Internet.password
    f.image       { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'users', 'avatar.jpg')) }
    f.role       'Customer'
    f.profile     Faker::Lorem.sentence
    f.auth_token  SecureRandom.urlsafe_base64
    #f.first_name  Faker::Name.first_name
    #f.last_name   Faker::Name.last_name
    #f.avatar_url  Faker::Avatar.image
    f.show_welcome_message  false
    f.activated  true
    f.uuid  "509487b2-079e-11e4-ab32-d43d7eecec4d"
    f.invited false
    f.administrator true
    f.has_a_collection true
    f.old_role "Super"
    f.account_activated true
    f.provider  "DigiRAMP"
    f.uid  "509487b2-079e-11e4-ab32-d43d7eecec4d"
    f.email_missing false
    #f.social_avatar Faker::Avatar.image
    f.salesperson false
    f.slug slug
  end
  

end