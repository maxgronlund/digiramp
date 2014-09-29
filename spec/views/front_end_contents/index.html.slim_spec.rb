require 'rails_helper'

RSpec.describe "front_end_contents/index", :type => :view do
  before(:each) do
    assign(:front_end_contents, [
      FrontEndContent.create!(
        :identifyer => "Identifyer",
        :page1_title_1 => "Page1 Title 1",
        :page1_title_2 => "Page1 Title 2",
        :page_1_body => "MyText",
        :page_1_image => "Page 1 Image",
        :page2_title => "Page2 Title",
        :page_2_headline => "MyText",
        :page_2_option_1_title => "Page 2 Option 1 Title",
        :page_2_option_1_headline => "Page 2 Option 1 Headline",
        :page_2_option_1_body => "MyText",
        :page_2_option_2_title => "Page 2 Option 2 Title",
        :page_2_option_2_headline => "Page 2 Option 2 Headline",
        :page_2_option_2_body => "MyText",
        :page_2_option_3_title => "Page 2 Option 3 Title",
        :page_2_option_3_headline => "Page 2 Option 3 Headline",
        :page_2_option_3_body => "MyText",
        :page_3_title => "Page 3 Title",
        :page_3_headline => "Page 3 Headline",
        :page_3_option_1_title => "Page 3 Option 1 Title",
        :page_3_option_1_body => "MyText",
        :page_3_option_2_title => "Page 3 Option 2 Title",
        :page_3_option_2_body => "MyText",
        :page_3_image => "Page 3 Image",
        :page_4_title => "Page 4 Title",
        :page_4_body => "MyText",
        :page_4_account_1_title => "Page 4 Account 1 Title",
        :page_4_account_1_title => "Page 4 Account 1 Title",
        :page_4_account_1_price => "Page 4 Account 1 Price",
        :page_4_account_1_option_1 => "Page 4 Account 1 Option 1",
        :page_4_account_1_option_2 => "Page 4 Account 1 Option 2",
        :page_4_account_1_option_3 => "Page 4 Account 1 Option 3",
        :page_4_account_1_option_4 => "Page 4 Account 1 Option 4",
        :page_4_account_1_option_5 => "Page 4 Account 1 Option 5",
        :page_4_account_1_option_6 => "Page 4 Account 1 Option 6",
        :page_4_account_2_title => "Page 4 Account 2 Title",
        :page_4_account_2_price => "Page 4 Account 2 Price",
        :page_4_account_2_option_1 => "Page 4 Account 2 Option 1",
        :page_4_account_2_option_2 => "Page 4 Account 2 Option 2",
        :page_4_account_2_option_3 => "Page 4 Account 2 Option 3",
        :page_4_account_2_option_4 => "Page 4 Account 2 Option 4",
        :page_4_account_2_option_5 => "Page 4 Account 2 Option 5",
        :page_4_account_2_option_6 => "Page 4 Account 2 Option 6",
        :page_4_account_3_title => "Page 4 Account 3 Title",
        :page_4_account_3_price => "Page 4 Account 3 Price",
        :page_4_account_3_option_1 => "Page 4 Account 3 Option 1",
        :page_4_account_3_option_2 => "Page 4 Account 3 Option 2",
        :page_4_account_3_option_3 => "Page 4 Account 3 Option 3",
        :page_4_account_3_option_4 => "Page 4 Account 3 Option 4",
        :page_4_account_3_option_5 => "Page 4 Account 3 Option 5",
        :page_4_account_3_option_6 => "Page 4 Account 3 Option 6",
        :page_4_account_4_title => "Page 4 Account 4 Title",
        :page_4_account_4_price => "Page 4 Account 4 Price",
        :page_4_account_4_option_1 => "Page 4 Account 4 Option 1",
        :page_4_account_4_option_2 => "Page 4 Account 4 Option 2",
        :page_4_account_4_option_3 => "Page 4 Account 4 Option 3",
        :page_4_account_4_option_4 => "Page 4 Account 4 Option 4",
        :page_4_account_4_option_5 => "Page 4 Account 4 Option 5",
        :page_4_account_4_option_6 => "Page 4 Account 4 Option 6",
        :page_4_title => "Page 4 Title",
        :page_4_body => "MyText",
        :page_4_image_1 => "Page 4 Image 1",
        :page_4_image_2 => "Page 4 Image 2",
        :page_4_image_3 => "Page 4 Image 3",
        :page_4_image_4 => "Page 4 Image 4",
        :page_4_image_5 => "Page 4 Image 5",
        :page_4_image_6 => "Page 4 Image 6",
        :page_5_testimonial_1_image => "Page 5 Testimonial 1 Image",
        :page_5_testimonial_1_name => "Page 5 Testimonial 1 Name",
        :page_5_testimonial_1_body => "MyText",
        :page_5_testimonial_2_image => "Page 5 Testimonial 2 Image",
        :page_5_testimonial_2_name => "Page 5 Testimonial 2 Name",
        :page_5_testimonial_2_body => "MyText",
        :page_5_testimonial_3_image => "Page 5 Testimonial 3 Image",
        :page_5_testimonial_3_name => "Page 5 Testimonial 3 Name",
        :page_5_testimonial_3_body => "MyText",
        :page_5_testimonial_4_image => "Page 5 Testimonial 4 Image",
        :page_5_testimonial_4_name => "Page 5 Testimonial 4 Name",
        :page_5_testimonial_4_body => "MyText",
        :page_5_testimonial_5_image => "Page 5 Testimonial 5 Image",
        :page_5_testimonial_5_name => "Page 5 Testimonial 5 Name",
        :page_5_testimonial_5_body => "MyText",
        :page_5_testimonial_5_image => "Page 5 Testimonial 5 Image",
        :page_5_testimonial_5_name => "Page 5 Testimonial 5 Name",
        :page_5_testimonial_5_body => "MyText",
        :page_6_title => "Page 6 Title",
        :page_6_headline => "Page 6 Headline",
        :page_6_body => "MyText",
        :page_6_image => "Page 6 Image",
        :page_7_title => "Page 7 Title",
        :page_7_body => "MyText"
      ),
      FrontEndContent.create!(
        :identifyer => "Identifyer",
        :page1_title_1 => "Page1 Title 1",
        :page1_title_2 => "Page1 Title 2",
        :page_1_body => "MyText",
        :page_1_image => "Page 1 Image",
        :page2_title => "Page2 Title",
        :page_2_headline => "MyText",
        :page_2_option_1_title => "Page 2 Option 1 Title",
        :page_2_option_1_headline => "Page 2 Option 1 Headline",
        :page_2_option_1_body => "MyText",
        :page_2_option_2_title => "Page 2 Option 2 Title",
        :page_2_option_2_headline => "Page 2 Option 2 Headline",
        :page_2_option_2_body => "MyText",
        :page_2_option_3_title => "Page 2 Option 3 Title",
        :page_2_option_3_headline => "Page 2 Option 3 Headline",
        :page_2_option_3_body => "MyText",
        :page_3_title => "Page 3 Title",
        :page_3_headline => "Page 3 Headline",
        :page_3_option_1_title => "Page 3 Option 1 Title",
        :page_3_option_1_body => "MyText",
        :page_3_option_2_title => "Page 3 Option 2 Title",
        :page_3_option_2_body => "MyText",
        :page_3_image => "Page 3 Image",
        :page_4_title => "Page 4 Title",
        :page_4_body => "MyText",
        :page_4_account_1_title => "Page 4 Account 1 Title",
        :page_4_account_1_title => "Page 4 Account 1 Title",
        :page_4_account_1_price => "Page 4 Account 1 Price",
        :page_4_account_1_option_1 => "Page 4 Account 1 Option 1",
        :page_4_account_1_option_2 => "Page 4 Account 1 Option 2",
        :page_4_account_1_option_3 => "Page 4 Account 1 Option 3",
        :page_4_account_1_option_4 => "Page 4 Account 1 Option 4",
        :page_4_account_1_option_5 => "Page 4 Account 1 Option 5",
        :page_4_account_1_option_6 => "Page 4 Account 1 Option 6",
        :page_4_account_2_title => "Page 4 Account 2 Title",
        :page_4_account_2_price => "Page 4 Account 2 Price",
        :page_4_account_2_option_1 => "Page 4 Account 2 Option 1",
        :page_4_account_2_option_2 => "Page 4 Account 2 Option 2",
        :page_4_account_2_option_3 => "Page 4 Account 2 Option 3",
        :page_4_account_2_option_4 => "Page 4 Account 2 Option 4",
        :page_4_account_2_option_5 => "Page 4 Account 2 Option 5",
        :page_4_account_2_option_6 => "Page 4 Account 2 Option 6",
        :page_4_account_3_title => "Page 4 Account 3 Title",
        :page_4_account_3_price => "Page 4 Account 3 Price",
        :page_4_account_3_option_1 => "Page 4 Account 3 Option 1",
        :page_4_account_3_option_2 => "Page 4 Account 3 Option 2",
        :page_4_account_3_option_3 => "Page 4 Account 3 Option 3",
        :page_4_account_3_option_4 => "Page 4 Account 3 Option 4",
        :page_4_account_3_option_5 => "Page 4 Account 3 Option 5",
        :page_4_account_3_option_6 => "Page 4 Account 3 Option 6",
        :page_4_account_4_title => "Page 4 Account 4 Title",
        :page_4_account_4_price => "Page 4 Account 4 Price",
        :page_4_account_4_option_1 => "Page 4 Account 4 Option 1",
        :page_4_account_4_option_2 => "Page 4 Account 4 Option 2",
        :page_4_account_4_option_3 => "Page 4 Account 4 Option 3",
        :page_4_account_4_option_4 => "Page 4 Account 4 Option 4",
        :page_4_account_4_option_5 => "Page 4 Account 4 Option 5",
        :page_4_account_4_option_6 => "Page 4 Account 4 Option 6",
        :page_4_title => "Page 4 Title",
        :page_4_body => "MyText",
        :page_4_image_1 => "Page 4 Image 1",
        :page_4_image_2 => "Page 4 Image 2",
        :page_4_image_3 => "Page 4 Image 3",
        :page_4_image_4 => "Page 4 Image 4",
        :page_4_image_5 => "Page 4 Image 5",
        :page_4_image_6 => "Page 4 Image 6",
        :page_5_testimonial_1_image => "Page 5 Testimonial 1 Image",
        :page_5_testimonial_1_name => "Page 5 Testimonial 1 Name",
        :page_5_testimonial_1_body => "MyText",
        :page_5_testimonial_2_image => "Page 5 Testimonial 2 Image",
        :page_5_testimonial_2_name => "Page 5 Testimonial 2 Name",
        :page_5_testimonial_2_body => "MyText",
        :page_5_testimonial_3_image => "Page 5 Testimonial 3 Image",
        :page_5_testimonial_3_name => "Page 5 Testimonial 3 Name",
        :page_5_testimonial_3_body => "MyText",
        :page_5_testimonial_4_image => "Page 5 Testimonial 4 Image",
        :page_5_testimonial_4_name => "Page 5 Testimonial 4 Name",
        :page_5_testimonial_4_body => "MyText",
        :page_5_testimonial_5_image => "Page 5 Testimonial 5 Image",
        :page_5_testimonial_5_name => "Page 5 Testimonial 5 Name",
        :page_5_testimonial_5_body => "MyText",
        :page_5_testimonial_5_image => "Page 5 Testimonial 5 Image",
        :page_5_testimonial_5_name => "Page 5 Testimonial 5 Name",
        :page_5_testimonial_5_body => "MyText",
        :page_6_title => "Page 6 Title",
        :page_6_headline => "Page 6 Headline",
        :page_6_body => "MyText",
        :page_6_image => "Page 6 Image",
        :page_7_title => "Page 7 Title",
        :page_7_body => "MyText"
      )
    ])
  end

  it "renders a list of front_end_contents" do
    render
    assert_select "tr>td", :text => "Identifyer".to_s, :count => 2
    assert_select "tr>td", :text => "Page1 Title 1".to_s, :count => 2
    assert_select "tr>td", :text => "Page1 Title 2".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 1 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page2 Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 2 Option 1 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 2 Option 1 Headline".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 2 Option 2 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 2 Option 2 Headline".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 2 Option 3 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 2 Option 3 Headline".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 3 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 3 Headline".to_s, :count => 2
    assert_select "tr>td", :text => "Page 3 Option 1 Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 3 Option 2 Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 3 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Price".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Option 1".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Option 2".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Option 3".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Option 4".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Option 5".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 1 Option 6".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 2 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 2 Price".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 2 Option 1".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 2 Option 2".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 2 Option 3".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 2 Option 4".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 2 Option 5".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 2 Option 6".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 3 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 3 Price".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 3 Option 1".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 3 Option 2".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 3 Option 3".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 3 Option 4".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 3 Option 5".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 3 Option 6".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 4 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 4 Price".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 4 Option 1".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 4 Option 2".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 4 Option 3".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 4 Option 4".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 4 Option 5".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Account 4 Option 6".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Image 1".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Image 2".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Image 3".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Image 4".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Image 5".to_s, :count => 2
    assert_select "tr>td", :text => "Page 4 Image 6".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 1 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 1 Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 2 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 2 Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 3 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 3 Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 4 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 4 Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 5 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 5 Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 5 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page 5 Testimonial 5 Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 6 Title".to_s, :count => 2
    assert_select "tr>td", :text => "Page 6 Headline".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Page 6 Image".to_s, :count => 2
    assert_select "tr>td", :text => "Page 7 Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
