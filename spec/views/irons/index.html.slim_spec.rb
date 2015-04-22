require 'rails_helper'

RSpec.describe "irons/index", :type => :view do
  before(:each) do
    assign(:irons, [
      Iron.create!(
        :title => "Title"
      ),
      Iron.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of irons" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
