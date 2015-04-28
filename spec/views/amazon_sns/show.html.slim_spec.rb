require 'rails_helper'

RSpec.describe "amazon_sns/show", :type => :view do
  before(:each) do
    @amazon_sn = assign(:amazon_sn, AmazonSn.create!(
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
