require 'rails_helper'

RSpec.describe "cms_texts/edit", :type => :view do
  before(:each) do
    @cms_text = assign(:cms_text, CmsText.create!(
      :position => 1,
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit cms_text form" do
    render

    assert_select "form[action=?][method=?]", cms_text_path(@cms_text), "post" do

      assert_select "input#cms_text_position[name=?]", "cms_text[position]"

      assert_select "input#cms_text_title[name=?]", "cms_text[title]"

      assert_select "textarea#cms_text_body[name=?]", "cms_text[body]"
    end
  end
end
