require 'rails_helper'

RSpec.describe "forum_posts/edit", :type => :view do
  before(:each) do
    @forum_post = assign(:forum_post, ForumPost.create!(
      :title => "MyString",
      :body => "MyText",
      :image => "MyString",
      :user => nil,
      :forum => nil,
      :uniq_likes => "MyString",
      :published => false
    ))
  end

  it "renders the edit forum_post form" do
    render

    assert_select "form[action=?][method=?]", forum_post_path(@forum_post), "post" do

      assert_select "input#forum_post_title[name=?]", "forum_post[title]"

      assert_select "textarea#forum_post_body[name=?]", "forum_post[body]"

      assert_select "input#forum_post_image[name=?]", "forum_post[image]"

      assert_select "input#forum_post_user_id[name=?]", "forum_post[user_id]"

      assert_select "input#forum_post_forum_id[name=?]", "forum_post[forum_id]"

      assert_select "input#forum_post_uniq_likes[name=?]", "forum_post[uniq_likes]"

      assert_select "input#forum_post_published[name=?]", "forum_post[published]"
    end
  end
end
