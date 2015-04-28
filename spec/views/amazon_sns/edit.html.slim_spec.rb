require 'rails_helper'

RSpec.describe "amazon_sns/edit", :type => :view do
  before(:each) do
    @amazon_sn = assign(:amazon_sn, AmazonSn.create!(
      :title => "MyString"
    ))
  end

  it "renders the edit amazon_sn form" do
    render

    assert_select "form[action=?][method=?]", amazon_sn_path(@amazon_sn), "post" do

      assert_select "input#amazon_sn_title[name=?]", "amazon_sn[title]"
    end
  end
end
