require 'rails_helper'

RSpec.describe "forums/show", :type => :view do
  before(:each) do
    @forum = assign(:forum, Forum.create!(
      :title => "Title",
      :body => "MyText",
      :image => "Image",
      :user => nil,
      :public_forum => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
