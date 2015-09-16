class LabelWork < ActiveRecord::Base
  belongs_to :label
  belongs_to :common_work
end
