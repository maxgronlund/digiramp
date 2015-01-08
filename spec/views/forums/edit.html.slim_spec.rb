require 'rails_helper'

RSpec.describe "forums/edit", :type => :view do
  before(:each) do
    @forum = assign(:forum, Forum.create!(
      :title => "MyString",
      :body => "MyText",
      :image => "MyString",
      :user => nil,
      :public_forum => false
    ))
  end

  it "renders the edit forum form" do
    render

    assert_select "form[action=?][method=?]", forum_path(@forum), "post" do

      assert_select "input#forum_title[name=?]", "forum[title]"

      assert_select "textarea#forum_body[name=?]", "forum[body]"

      assert_select "input#forum_image[name=?]", "forum[image]"

      assert_select "input#forum_user_id[name=?]", "forum[user_id]"

      assert_select "input#forum_public_forum[name=?]", "forum[public_forum]"
    end
  end
end
