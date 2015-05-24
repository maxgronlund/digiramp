Then(/^I can edit the first user$/) do
  @user = User.first
  visit "/admin/users/#{@user.slug}/edit"
end