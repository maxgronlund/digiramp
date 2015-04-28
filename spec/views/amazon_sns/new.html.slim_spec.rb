require 'rails_helper'

RSpec.describe "amazon_sns/new", :type => :view do
  before(:each) do
    assign(:amazon_sn, AmazonSn.new(
      :title => "MyString"
    ))
  end

  it "renders new amazon_sn form" do
    render

    assert_select "form[action=?][method=?]", amazon_sns_path, "post" do

      assert_select "input#amazon_sn_title[name=?]", "amazon_sn[title]"
    end
  end
end
