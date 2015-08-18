class IpiPublishingAgreement < ActiveRecord::Base
  belongs_to :ipi
  belongs_to :publishing_agreement
end
