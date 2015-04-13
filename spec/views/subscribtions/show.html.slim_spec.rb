require 'rails_helper'

RSpec.describe "subscriptions/show", :type => :view do
  before(:each) do
    @subscription = assign(:subscription, ProUserSubscribtion.create!(
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
