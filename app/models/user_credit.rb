
class UserCredit < ActiveRecord::Base
  belongs_to :user
  belongs_to :ipiable, polymorphic: :true
end
