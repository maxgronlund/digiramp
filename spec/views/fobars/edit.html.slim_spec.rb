require 'rails_helper'

RSpec.describe "fobars/edit", :type => :view do
  before(:each) do
    @fobar = assign(:fobar, Fobar.create!(
      :index => "MyString"
    ))
  end

  it "renders the edit fobar form" do
    render

    assert_select "form[action=?][method=?]", fobar_path(@fobar), "post" do

      assert_select "input#fobar_index[name=?]", "fobar[index]"
    end
  end
end
