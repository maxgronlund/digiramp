require 'rails_helper'

RSpec.describe "publishers/edit", type: :view do
  before(:each) do
    @publisher = assign(:publisher, Publisher.create!(
      :user => "",
      :email, => "MyString",
      :phone_number, => "MyString",
      :ipi_code, => "MyString",
      :cae_code => "MyString",
      :uuid => "",
      :pro_affiliation => "",
      :status => 1
    ))
  end

  it "renders the edit publisher form" do
    render

    assert_select "form[action=?][method=?]", publisher_path(@publisher), "post" do

      assert_select "input#publisher_user[name=?]", "publisher[user]"

      assert_select "input#publisher_email,[name=?]", "publisher[email,]"

      assert_select "input#publisher_phone_number,[name=?]", "publisher[phone_number,]"

      assert_select "input#publisher_ipi_code,[name=?]", "publisher[ipi_code,]"

      assert_select "input#publisher_cae_code[name=?]", "publisher[cae_code]"

      assert_select "input#publisher_uuid[name=?]", "publisher[uuid]"

      assert_select "input#publisher_pro_affiliation[name=?]", "publisher[pro_affiliation]"

      assert_select "input#publisher_status[name=?]", "publisher[status]"
    end
  end
end
