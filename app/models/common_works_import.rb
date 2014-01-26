class CommonWorksImport < ActiveRecord::Base
  belongs_to :account
  #attr_accessible :title, :body, :imported_works, :in_progress, :params, :processed_works, :total_works, :updated_works
  has_many :common_works, dependent: :destroy

end
