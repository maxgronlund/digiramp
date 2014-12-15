require 'rails_helper'

RSpec.describe "connections/new", :type => :view do
  before(:each) do
    assign(:connection, Connection.new(
      :user => nil,
      :connection_id => 1,
      :approved => false,
      :message => "MyText"
    ))
  end

  it "renders new connection form" do
    render

    assert_select "form[action=?][method=?]", connections_path, "post" do

      assert_select "input#connection_user_id[name=?]", "connection[user_id]"

      assert_select "input#connection_connection_id[name=?]", "connection[connection_id]"

      assert_select "input#connection_approved[name=?]", "connection[approved]"

      assert_select "textarea#connection_message[name=?]", "connection[message]"
    end
  end
end
