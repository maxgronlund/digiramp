require 'rails_helper'

RSpec.describe "fobars/new", :type => :view do
  before(:each) do
    assign(:fobar, Fobar.new(
      :index => "MyString"
    ))
  end

  it "renders new fobar form" do
    render

    assert_select "form[action=?][method=?]", fobars_path, "post" do

      assert_select "input#fobar_index[name=?]", "fobar[index]"
    end
  end
end
