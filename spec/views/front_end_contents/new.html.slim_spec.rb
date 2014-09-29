require 'rails_helper'

RSpec.describe "front_end_contents/new", :type => :view do
  before(:each) do
    assign(:front_end_content, FrontEndContent.new(
      :identifyer => "MyString",
      :page1_title_1 => "MyString",
      :page1_title_2 => "MyString",
      :page_1_body => "MyText",
      :page_1_image => "MyString",
      :page2_title => "MyString",
      :page_2_headline => "MyText",
      :page_2_option_1_title => "MyString",
      :page_2_option_1_headline => "MyString",
      :page_2_option_1_body => "MyText",
      :page_2_option_2_title => "MyString",
      :page_2_option_2_headline => "MyString",
      :page_2_option_2_body => "MyText",
      :page_2_option_3_title => "MyString",
      :page_2_option_3_headline => "MyString",
      :page_2_option_3_body => "MyText",
      :page_3_title => "MyString",
      :page_3_headline => "MyString",
      :page_3_option_1_title => "MyString",
      :page_3_option_1_body => "MyText",
      :page_3_option_2_title => "MyString",
      :page_3_option_2_body => "MyText",
      :page_3_image => "MyString",
      :page_4_title => "MyString",
      :page_4_body => "MyText",
      :page_4_account_1_title => "MyString",
      :page_4_account_1_title => "MyString",
      :page_4_account_1_price => "MyString",
      :page_4_account_1_option_1 => "MyString",
      :page_4_account_1_option_2 => "MyString",
      :page_4_account_1_option_3 => "MyString",
      :page_4_account_1_option_4 => "MyString",
      :page_4_account_1_option_5 => "MyString",
      :page_4_account_1_option_6 => "MyString",
      :page_4_account_2_title => "MyString",
      :page_4_account_2_price => "MyString",
      :page_4_account_2_option_1 => "MyString",
      :page_4_account_2_option_2 => "MyString",
      :page_4_account_2_option_3 => "MyString",
      :page_4_account_2_option_4 => "MyString",
      :page_4_account_2_option_5 => "MyString",
      :page_4_account_2_option_6 => "MyString",
      :page_4_account_3_title => "MyString",
      :page_4_account_3_price => "MyString",
      :page_4_account_3_option_1 => "MyString",
      :page_4_account_3_option_2 => "MyString",
      :page_4_account_3_option_3 => "MyString",
      :page_4_account_3_option_4 => "MyString",
      :page_4_account_3_option_5 => "MyString",
      :page_4_account_3_option_6 => "MyString",
      :page_4_account_4_title => "MyString",
      :page_4_account_4_price => "MyString",
      :page_4_account_4_option_1 => "MyString",
      :page_4_account_4_option_2 => "MyString",
      :page_4_account_4_option_3 => "MyString",
      :page_4_account_4_option_4 => "MyString",
      :page_4_account_4_option_5 => "MyString",
      :page_4_account_4_option_6 => "MyString",
      :page_4_title => "MyString",
      :page_4_body => "MyText",
      :page_4_image_1 => "MyString",
      :page_4_image_2 => "MyString",
      :page_4_image_3 => "MyString",
      :page_4_image_4 => "MyString",
      :page_4_image_5 => "MyString",
      :page_4_image_6 => "MyString",
      :page_5_testimonial_1_image => "MyString",
      :page_5_testimonial_1_name => "MyString",
      :page_5_testimonial_1_body => "MyText",
      :page_5_testimonial_2_image => "MyString",
      :page_5_testimonial_2_name => "MyString",
      :page_5_testimonial_2_body => "MyText",
      :page_5_testimonial_3_image => "MyString",
      :page_5_testimonial_3_name => "MyString",
      :page_5_testimonial_3_body => "MyText",
      :page_5_testimonial_4_image => "MyString",
      :page_5_testimonial_4_name => "MyString",
      :page_5_testimonial_4_body => "MyText",
      :page_5_testimonial_5_image => "MyString",
      :page_5_testimonial_5_name => "MyString",
      :page_5_testimonial_5_body => "MyText",
      :page_5_testimonial_5_image => "MyString",
      :page_5_testimonial_5_name => "MyString",
      :page_5_testimonial_5_body => "MyText",
      :page_6_title => "MyString",
      :page_6_headline => "MyString",
      :page_6_body => "MyText",
      :page_6_image => "MyString",
      :page_7_title => "MyString",
      :page_7_body => "MyText"
    ))
  end

  it "renders new front_end_content form" do
    render

    assert_select "form[action=?][method=?]", front_end_contents_path, "post" do

      assert_select "input#front_end_content_identifyer[name=?]", "front_end_content[identifyer]"

      assert_select "input#front_end_content_page1_title_1[name=?]", "front_end_content[page1_title_1]"

      assert_select "input#front_end_content_page1_title_2[name=?]", "front_end_content[page1_title_2]"

      assert_select "textarea#front_end_content_page_1_body[name=?]", "front_end_content[page_1_body]"

      assert_select "input#front_end_content_page_1_image[name=?]", "front_end_content[page_1_image]"

      assert_select "input#front_end_content_page2_title[name=?]", "front_end_content[page2_title]"

      assert_select "textarea#front_end_content_page_2_headline[name=?]", "front_end_content[page_2_headline]"

      assert_select "input#front_end_content_page_2_option_1_title[name=?]", "front_end_content[page_2_option_1_title]"

      assert_select "input#front_end_content_page_2_option_1_headline[name=?]", "front_end_content[page_2_option_1_headline]"

      assert_select "textarea#front_end_content_page_2_option_1_body[name=?]", "front_end_content[page_2_option_1_body]"

      assert_select "input#front_end_content_page_2_option_2_title[name=?]", "front_end_content[page_2_option_2_title]"

      assert_select "input#front_end_content_page_2_option_2_headline[name=?]", "front_end_content[page_2_option_2_headline]"

      assert_select "textarea#front_end_content_page_2_option_2_body[name=?]", "front_end_content[page_2_option_2_body]"

      assert_select "input#front_end_content_page_2_option_3_title[name=?]", "front_end_content[page_2_option_3_title]"

      assert_select "input#front_end_content_page_2_option_3_headline[name=?]", "front_end_content[page_2_option_3_headline]"

      assert_select "textarea#front_end_content_page_2_option_3_body[name=?]", "front_end_content[page_2_option_3_body]"

      assert_select "input#front_end_content_page_3_title[name=?]", "front_end_content[page_3_title]"

      assert_select "input#front_end_content_page_3_headline[name=?]", "front_end_content[page_3_headline]"

      assert_select "input#front_end_content_page_3_option_1_title[name=?]", "front_end_content[page_3_option_1_title]"

      assert_select "textarea#front_end_content_page_3_option_1_body[name=?]", "front_end_content[page_3_option_1_body]"

      assert_select "input#front_end_content_page_3_option_2_title[name=?]", "front_end_content[page_3_option_2_title]"

      assert_select "textarea#front_end_content_page_3_option_2_body[name=?]", "front_end_content[page_3_option_2_body]"

      assert_select "input#front_end_content_page_3_image[name=?]", "front_end_content[page_3_image]"

      assert_select "input#front_end_content_page_4_title[name=?]", "front_end_content[page_4_title]"

      assert_select "textarea#front_end_content_page_4_body[name=?]", "front_end_content[page_4_body]"

      assert_select "input#front_end_content_page_4_account_1_title[name=?]", "front_end_content[page_4_account_1_title]"

      assert_select "input#front_end_content_page_4_account_1_title[name=?]", "front_end_content[page_4_account_1_title]"

      assert_select "input#front_end_content_page_4_account_1_price[name=?]", "front_end_content[page_4_account_1_price]"

      assert_select "input#front_end_content_page_4_account_1_option_1[name=?]", "front_end_content[page_4_account_1_option_1]"

      assert_select "input#front_end_content_page_4_account_1_option_2[name=?]", "front_end_content[page_4_account_1_option_2]"

      assert_select "input#front_end_content_page_4_account_1_option_3[name=?]", "front_end_content[page_4_account_1_option_3]"

      assert_select "input#front_end_content_page_4_account_1_option_4[name=?]", "front_end_content[page_4_account_1_option_4]"

      assert_select "input#front_end_content_page_4_account_1_option_5[name=?]", "front_end_content[page_4_account_1_option_5]"

      assert_select "input#front_end_content_page_4_account_1_option_6[name=?]", "front_end_content[page_4_account_1_option_6]"

      assert_select "input#front_end_content_page_4_account_2_title[name=?]", "front_end_content[page_4_account_2_title]"

      assert_select "input#front_end_content_page_4_account_2_price[name=?]", "front_end_content[page_4_account_2_price]"

      assert_select "input#front_end_content_page_4_account_2_option_1[name=?]", "front_end_content[page_4_account_2_option_1]"

      assert_select "input#front_end_content_page_4_account_2_option_2[name=?]", "front_end_content[page_4_account_2_option_2]"

      assert_select "input#front_end_content_page_4_account_2_option_3[name=?]", "front_end_content[page_4_account_2_option_3]"

      assert_select "input#front_end_content_page_4_account_2_option_4[name=?]", "front_end_content[page_4_account_2_option_4]"

      assert_select "input#front_end_content_page_4_account_2_option_5[name=?]", "front_end_content[page_4_account_2_option_5]"

      assert_select "input#front_end_content_page_4_account_2_option_6[name=?]", "front_end_content[page_4_account_2_option_6]"

      assert_select "input#front_end_content_page_4_account_3_title[name=?]", "front_end_content[page_4_account_3_title]"

      assert_select "input#front_end_content_page_4_account_3_price[name=?]", "front_end_content[page_4_account_3_price]"

      assert_select "input#front_end_content_page_4_account_3_option_1[name=?]", "front_end_content[page_4_account_3_option_1]"

      assert_select "input#front_end_content_page_4_account_3_option_2[name=?]", "front_end_content[page_4_account_3_option_2]"

      assert_select "input#front_end_content_page_4_account_3_option_3[name=?]", "front_end_content[page_4_account_3_option_3]"

      assert_select "input#front_end_content_page_4_account_3_option_4[name=?]", "front_end_content[page_4_account_3_option_4]"

      assert_select "input#front_end_content_page_4_account_3_option_5[name=?]", "front_end_content[page_4_account_3_option_5]"

      assert_select "input#front_end_content_page_4_account_3_option_6[name=?]", "front_end_content[page_4_account_3_option_6]"

      assert_select "input#front_end_content_page_4_account_4_title[name=?]", "front_end_content[page_4_account_4_title]"

      assert_select "input#front_end_content_page_4_account_4_price[name=?]", "front_end_content[page_4_account_4_price]"

      assert_select "input#front_end_content_page_4_account_4_option_1[name=?]", "front_end_content[page_4_account_4_option_1]"

      assert_select "input#front_end_content_page_4_account_4_option_2[name=?]", "front_end_content[page_4_account_4_option_2]"

      assert_select "input#front_end_content_page_4_account_4_option_3[name=?]", "front_end_content[page_4_account_4_option_3]"

      assert_select "input#front_end_content_page_4_account_4_option_4[name=?]", "front_end_content[page_4_account_4_option_4]"

      assert_select "input#front_end_content_page_4_account_4_option_5[name=?]", "front_end_content[page_4_account_4_option_5]"

      assert_select "input#front_end_content_page_4_account_4_option_6[name=?]", "front_end_content[page_4_account_4_option_6]"

      assert_select "input#front_end_content_page_4_title[name=?]", "front_end_content[page_4_title]"

      assert_select "textarea#front_end_content_page_4_body[name=?]", "front_end_content[page_4_body]"

      assert_select "input#front_end_content_page_4_image_1[name=?]", "front_end_content[page_4_image_1]"

      assert_select "input#front_end_content_page_4_image_2[name=?]", "front_end_content[page_4_image_2]"

      assert_select "input#front_end_content_page_4_image_3[name=?]", "front_end_content[page_4_image_3]"

      assert_select "input#front_end_content_page_4_image_4[name=?]", "front_end_content[page_4_image_4]"

      assert_select "input#front_end_content_page_4_image_5[name=?]", "front_end_content[page_4_image_5]"

      assert_select "input#front_end_content_page_4_image_6[name=?]", "front_end_content[page_4_image_6]"

      assert_select "input#front_end_content_page_5_testimonial_1_image[name=?]", "front_end_content[page_5_testimonial_1_image]"

      assert_select "input#front_end_content_page_5_testimonial_1_name[name=?]", "front_end_content[page_5_testimonial_1_name]"

      assert_select "textarea#front_end_content_page_5_testimonial_1_body[name=?]", "front_end_content[page_5_testimonial_1_body]"

      assert_select "input#front_end_content_page_5_testimonial_2_image[name=?]", "front_end_content[page_5_testimonial_2_image]"

      assert_select "input#front_end_content_page_5_testimonial_2_name[name=?]", "front_end_content[page_5_testimonial_2_name]"

      assert_select "textarea#front_end_content_page_5_testimonial_2_body[name=?]", "front_end_content[page_5_testimonial_2_body]"

      assert_select "input#front_end_content_page_5_testimonial_3_image[name=?]", "front_end_content[page_5_testimonial_3_image]"

      assert_select "input#front_end_content_page_5_testimonial_3_name[name=?]", "front_end_content[page_5_testimonial_3_name]"

      assert_select "textarea#front_end_content_page_5_testimonial_3_body[name=?]", "front_end_content[page_5_testimonial_3_body]"

      assert_select "input#front_end_content_page_5_testimonial_4_image[name=?]", "front_end_content[page_5_testimonial_4_image]"

      assert_select "input#front_end_content_page_5_testimonial_4_name[name=?]", "front_end_content[page_5_testimonial_4_name]"

      assert_select "textarea#front_end_content_page_5_testimonial_4_body[name=?]", "front_end_content[page_5_testimonial_4_body]"

      assert_select "input#front_end_content_page_5_testimonial_5_image[name=?]", "front_end_content[page_5_testimonial_5_image]"

      assert_select "input#front_end_content_page_5_testimonial_5_name[name=?]", "front_end_content[page_5_testimonial_5_name]"

      assert_select "textarea#front_end_content_page_5_testimonial_5_body[name=?]", "front_end_content[page_5_testimonial_5_body]"

      assert_select "input#front_end_content_page_5_testimonial_5_image[name=?]", "front_end_content[page_5_testimonial_5_image]"

      assert_select "input#front_end_content_page_5_testimonial_5_name[name=?]", "front_end_content[page_5_testimonial_5_name]"

      assert_select "textarea#front_end_content_page_5_testimonial_5_body[name=?]", "front_end_content[page_5_testimonial_5_body]"

      assert_select "input#front_end_content_page_6_title[name=?]", "front_end_content[page_6_title]"

      assert_select "input#front_end_content_page_6_headline[name=?]", "front_end_content[page_6_headline]"

      assert_select "textarea#front_end_content_page_6_body[name=?]", "front_end_content[page_6_body]"

      assert_select "input#front_end_content_page_6_image[name=?]", "front_end_content[page_6_image]"

      assert_select "input#front_end_content_page_7_title[name=?]", "front_end_content[page_7_title]"

      assert_select "textarea#front_end_content_page_7_body[name=?]", "front_end_content[page_7_body]"
    end
  end
end
