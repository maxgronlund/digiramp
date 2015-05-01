module KnowUsersHelper

  def find_or_create_user  name, email, password, role
    @user = User.where(email: email)
                .first_or_create(
                                  name: name,
                                  user_name: name,
                                  email: email,
                                  password: password,
                                  #password_digest: "$2a$10$uOacV2a4MtlCgH9rluewnOsF4QlLWpVFLKV1lCW5hJh0mXRRJEHwW",
                                  role: role,
                                  profile: 'Super duper administrator',
                                  #auth_token: SecureRandom.urlsafe_base64
                                  first_name:  name,
                                  last_name:  name + ' doe',
                                  show_welcome_message:  false,
                                  activated:  true,
                                  uuid:  "509487b2-079e-11e4-ab32-d43d7eecec4d",
                                  invited: false,
                                  administrator: true,
                                  has_a_collection: true,
                                  old_role: role,
                                  account_activated: true,
                                  provider: "DigiRAMP",
                                  uid: "",
                                  email_missing: false,
                                  social_avatar: "",
                                  slug: name + "-doe"
                                )
      @user.authenticate(@user.password)
      @account          = User.create_a_new_account_for_the @user
    
  end
  
 
  
  #def create_user role, first_name, last_name , email, password, super_user
  #  user = User.new()
  #  user.first_name = first_name
  #  user.last_name  = last_name
  #  user.role       = role
  #  
  #  user.super_user = super_user
  #  user.save  validate: false
  #  user.profile = MemberProfile.new email: email, password: password, password_confirmation: password
  #  user.email      = email
  #  user.profile.save!
  #  user.save  validate: false
  #end
  
end

World(KnowUsersHelper)