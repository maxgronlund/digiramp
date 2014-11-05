#require 'test/unit'
#include Minitest::Test::Assertions
#include ActiveSupport::TestCase

module KnowSitesHelper
  
  #def find_or_create_site site_title, default_user, default_language, page_layout, site_type
  #
  #  valuta = { en: 'GBP', dk: 'DKK', fi: 'EURO', se: 'SEK', no: 'NOK', de: 'EURO', fr: 'EURO', pl: 'EURO', it: 'EURO',  es: 'EURO', nl: 'EURO', ru: 'EURO'}    
  #  site = Site.where(title: site_title).first_or_create!(title: site_title, 
  #                                                  #slug: site_title, 
  #                                                  site_url:             site_title.gsub(' ', '_').downcase!,
  #                                                  default_user_id:      default_user.id, 
  #                                                  default_language_id:  default_language.id, 
  #                                                  page_layout:          page_layout,
  #                                                  header_left_text:     site_title,
  #                                                  enable_site:          true,
  #                                                  site_type:            site_type,
  #                                                  currency:             valuta[default_language.name.to_sym],
  #                                                  enable_basket:        true,
  #                                                  enable_login:         true,
  #                                                  vat:                  25
  #                                                  )
  #  #default language                                                
  #  Langualization.where(site_id: site.id, language_id: default_language.id).first_or_create(site_id: site.id, language_id: default_language.id)
  #  ShippingRate.create(fee: 5, amount_limit: 50, shipping_contry: 'England', site_id: site.id, calculation_method: 'Units')
  #  Received.create(title: 'received')
  #  
  #  Backend.first.cucumber_test = true
  #  Backend.first.save!
  #  site
  #end
  #
  #def site site_title
  #  site          = Site.where(title: site_title).first
  #  refute_nil( site,  'ERROR >>>>>>>>> site not found <<<<<<<<<<<<<<<<<')
  #  site
  #end
  

end

World(KnowSitesHelper)