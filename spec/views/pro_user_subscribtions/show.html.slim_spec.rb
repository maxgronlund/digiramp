require 'rails_helper'

RSpec.describe "pro_user_subscribtions/show", :type => :view do
  before(:each) do
    @pro_user_subscribtion = assign(:pro_user_subscribtion, ProUserSubscribtion.create!(
      :email => "Email",
      :user => nil,
      :account => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
