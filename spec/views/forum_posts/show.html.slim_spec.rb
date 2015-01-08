require 'rails_helper'

RSpec.describe "forum_posts/show", :type => :view do
  before(:each) do
    @forum_post = assign(:forum_post, ForumPost.create!(
      :title => "Title",
      :body => "MyText",
      :image => "Image",
      :user => nil,
      :forum => nil,
      :uniq_likes => "Uniq Likes",
      :published => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Uniq Likes/)
    expect(rendered).to match(/false/)
  end
end
