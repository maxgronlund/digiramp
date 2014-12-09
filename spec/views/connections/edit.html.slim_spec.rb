require 'rails_helper'

RSpec.describe "connections/edit", :type => :view do
  before(:each) do
    @connection = assign(:connection, Connection.create!(
      :user => nil,
      :connection_id => 1,
      :approved => false,
      :message => "MyText"
    ))
  end

  it "renders the edit connection form" do
    render

    assert_select "form[action=?][method=?]", connection_path(@connection), "post" do

      assert_select "input#connection_user_id[name=?]", "connection[user_id]"

      assert_select "input#connection_connection_id[name=?]", "connection[connection_id]"

      assert_select "input#connection_approved[name=?]", "connection[approved]"

      assert_select "textarea#connection_message[name=?]", "connection[message]"
    end
  end
end
