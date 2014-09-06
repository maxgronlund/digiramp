require 'rails_helper'

RSpec.describe "fobars/index", :type => :view do
  before(:each) do
    assign(:fobars, [
      Fobar.create!(
        :index => "Index"
      ),
      Fobar.create!(
        :index => "Index"
      )
    ])
  end

  it "renders a list of fobars" do
    render
    assert_select "tr>td", :text => "Index".to_s, :count => 2
  end
end
