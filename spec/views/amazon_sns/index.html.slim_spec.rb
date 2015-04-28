require 'rails_helper'

RSpec.describe "amazon_sns/index", :type => :view do
  before(:each) do
    assign(:amazon_sns, [
      AmazonSn.create!(
        :title => "Title"
      ),
      AmazonSn.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of amazon_sns" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
