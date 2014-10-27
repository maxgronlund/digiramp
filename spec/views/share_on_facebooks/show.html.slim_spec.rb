require 'rails_helper'

RSpec.describe "share_on_facebooks/show", :type => :view do
  before(:each) do
    @share_on_facebook = assign(:share_on_facebook, ShareOnFacebook.create!(
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
