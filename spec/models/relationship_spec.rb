# free after https://www.railstutorial.org/book/following_users
require 'rails_helper'

RSpec.describe Relationship, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }
end
