require 'rails_helper'

RSpec.describe "contracts/new", :type => :view do
  before(:each) do
    assign(:contract, Contract.new(
      :title => "MyString",
      :subject => "MyText"
    ))
  end

  it "renders new contract form" do
    render

    assert_select "form[action=?][method=?]", contracts_path, "post" do

      assert_select "input#contract_title[name=?]", "contract[title]"

      assert_select "textarea#contract_subject[name=?]", "contract[subject]"
    end
  end
end
