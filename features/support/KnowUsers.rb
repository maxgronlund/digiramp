module KnowUsersHelper

  def find_or_create_user  name, email, password, role
    return @user if @user = user_with_email( email )
    @page_style         = FactoryGirl.create(:page_style)
    @user               = FactoryGirl.create(:user, user_name: name, email: email, password: password, role: role, slug: name.downcase.gsub(' ', '_'), betatester: true)
    @user.page_style_id = @page_style.id
    @user.save!
    @account            = User.create_a_new_account_for_the (@user)
    @user
  end
  
  def user_with_email email
    User.find_by(email: email)
  end
  
  def get_user email
    find_or_create_user Faker::Name.name, email, Faker::Internet.password, 'Customer'
  end
  
  def user_with_name name
    
    User.find_by(user_name: name)
  end

  
end

World(KnowUsersHelper)