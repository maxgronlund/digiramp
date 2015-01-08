require 'rails_helper'

RSpec.describe "forum_posts/index", :type => :view do
  before(:each) do
    assign(:forum_posts, [
      ForumPost.create!(
        :title => "Title",
        :body => "MyText",
        :image => "Image",
        :user => nil,
        :forum => nil,
        :uniq_likes => "Uniq Likes",
        :published => false
      ),
      ForumPost.create!(
        :title => "Title",
        :body => "MyText",
        :image => "Image",
        :user => nil,
        :forum => nil,
        :uniq_likes => "Uniq Likes",
        :published => false
      )
    ])
  end

  it "renders a list of forum_posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Uniq Likes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
