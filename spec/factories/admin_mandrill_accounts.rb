FactoryGirl.define do
  factory :admin_mandrill_account, :class => 'Admin::MandrillAccount' do
    account nil
notes "MyString"
custom_quota 1
  end

end
