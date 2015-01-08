require 'rails_helper'

RSpec.describe "forums/index", :type => :view do
  before(:each) do
    assign(:forums, [
      Forum.create!(
        :title => "Title",
        :body => "MyText",
        :image => "Image",
        :user => nil,
        :public_forum => false
      ),
      Forum.create!(
        :title => "Title",
        :body => "MyText",
        :image => "Image",
        :user => nil,
        :public_forum => false
      )
    ])
  end

  it "renders a list of forums" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
