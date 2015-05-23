

FactoryGirl.define do
  
  factory :user do |f|
    #sequence(:user_name) { |n| "foo#{n}" }
    f.name 'Administrator'
    f.user_name 'Administrator'
    f.email 'max@digiramp.com'
    f.password 'adminadmin'
    f.image     Faker::Avatar.image
    #f.password_digest "$2a$10$uOacV2a4MtlCgH9rluewnOsF4QlLWpVFLKV1lCW5hJh0mXRRJEHwW"
    f.role 'Super'
    f.profile 'Super duper administrator'
    f.auth_token SecureRandom.urlsafe_base64
    f.first_name  "Max Groenlund"
    f.last_name  'groenlund'
    f.avatar_url  nil
    f.show_welcome_message  false
    f.activated  true
    f.uuid  "509487b2-079e-11e4-ab32-d43d7eecec4d"
    f.invited false
    f.administrator true
    f.has_a_collection true
    f.old_role "Super"
    f.account_activated true
    f.provider  "DigiRAMP"
    f.uid  ""
    f.email_missing false
    f.social_avatar ""
    f.slug "max-groenlund"
    f.salesperson false
    f.betatester true
    
  end
end