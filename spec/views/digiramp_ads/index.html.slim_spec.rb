require 'rails_helper'

RSpec.describe "digiramp_ads/index", :type => :view do
  before(:each) do
    assign(:digiramp_ads, [
      DigirampAd.create!(
        :identifyer => "Identifyer",
        :title => "Title",
        :body => "MyText",
        :image => "Image",
        :snippet => "Snippet",
        :link => "Link",
        :button_link => "Button Link",
        :button_style => "Button Style",
        :css_snipet => "MyText"
      ),
      DigirampAd.create!(
        :identifyer => "Identifyer",
        :title => "Title",
        :body => "MyText",
        :image => "Image",
        :snippet => "Snippet",
        :link => "Link",
        :button_link => "Button Link",
        :button_style => "Button Style",
        :css_snipet => "MyText"
      )
    ])
  end

  it "renders a list of digiramp_ads" do
    render
    assert_select "tr>td", :text => "Identifyer".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Snippet".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Button Link".to_s, :count => 2
    assert_select "tr>td", :text => "Button Style".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
