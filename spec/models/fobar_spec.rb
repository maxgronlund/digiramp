require 'rails_helper'


RSpec.describe Fobar, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it 'says hello' do
    fobar = FactoryGirl.create :fobar
    assert_equal( 'hello', fobar.say_hello, failure_message = 'Not right' )
  end
end
