class Admin::LegalTag < ActiveRecord::Base
  validates :title, :body, presence: true, uniqueness: true
  
  def self.build_default_tags
    Admin::LegalTag.where(title: 'Recording', body: 'Sale and licences for recordings')
                   .first_or_create(title: 'Recording', body: 'Sale and licences for recordings')
    Admin::LegalTag.where(title: 'Physical product', body: 'Sale and licences for physical products')
                   .first_or_create(title: 'Physical product', body: 'Sale and licences for physical products')
    Admin::LegalTag.where(title: 'Service', body: 'Terms for sale of services')
                   .first_or_create(title: 'Service', body: 'Sale of services')
    Admin::LegalTag.where(title: 'Streaming', body: 'Terms for usage of streaming')
                   .first_or_create(title: 'Streaming', body: 'Terms for usage of streaming')
                   
  end
end
