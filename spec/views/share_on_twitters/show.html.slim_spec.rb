require 'rails_helper'

RSpec.describe "share_on_twitters/show", :type => :view do
  before(:each) do
    @share_on_twitter = assign(:share_on_twitter, ShareOnTwitter.create!(
      :user => nil,
      :recording => nil,
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
