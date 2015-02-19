require 'rails_helper'

RSpec.describe "contracts/edit", :type => :view do
  before(:each) do
    @contract = assign(:contract, Contract.create!(
      :title => "MyString",
      :subject => "MyText"
    ))
  end

  it "renders the edit contract form" do
    render

    assert_select "form[action=?][method=?]", contract_path(@contract), "post" do

      assert_select "input#contract_title[name=?]", "contract[title]"

      assert_select "textarea#contract_subject[name=?]", "contract[subject]"
    end
  end
end
