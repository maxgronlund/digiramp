require 'rails_helper'

RSpec.describe "digiramp_ads/new", :type => :view do
  before(:each) do
    assign(:digiramp_ad, DigirampAd.new(
      :identifyer => "MyString",
      :title => "MyString",
      :body => "MyText",
      :image => "MyString",
      :snippet => "MyString",
      :link => "MyString",
      :button_link => "MyString",
      :button_style => "MyString",
      :css_snipet => "MyText"
    ))
  end

  it "renders new digiramp_ad form" do
    render

    assert_select "form[action=?][method=?]", digiramp_ads_path, "post" do

      assert_select "input#digiramp_ad_identifyer[name=?]", "digiramp_ad[identifyer]"

      assert_select "input#digiramp_ad_title[name=?]", "digiramp_ad[title]"

      assert_select "textarea#digiramp_ad_body[name=?]", "digiramp_ad[body]"

      assert_select "input#digiramp_ad_image[name=?]", "digiramp_ad[image]"

      assert_select "input#digiramp_ad_snippet[name=?]", "digiramp_ad[snippet]"

      assert_select "input#digiramp_ad_link[name=?]", "digiramp_ad[link]"

      assert_select "input#digiramp_ad_button_link[name=?]", "digiramp_ad[button_link]"

      assert_select "input#digiramp_ad_button_style[name=?]", "digiramp_ad[button_style]"

      assert_select "textarea#digiramp_ad_css_snipet[name=?]", "digiramp_ad[css_snipet]"
    end
  end
end
