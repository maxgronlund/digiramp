require 'rails_helper'

RSpec.describe "cms_texts/index", :type => :view do
  before(:each) do
    assign(:cms_texts, [
      CmsText.create!(
        :position => 1,
        :title => "Title",
        :body => "MyText"
      ),
      CmsText.create!(
        :position => 1,
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of cms_texts" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
