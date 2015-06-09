class UserSettingsService
  
  def self.init user
    
    user.s = { betatester:            user.betatester, 
               salesperson:           user.salesperson,
               administrator:         user.administrator,
               provider:              user.provider,
               show_welcome_message:  user.show_welcome_message,
               activated:             user.activated,
               invited:               user.invited,
               has_enabled_shop:      user.has_enabled_shop,
               has_an_approved_shop:  user.has_an_approved_shop,
               old_role:              user.old_role,
               account_activated:     user.account_activated,
               initialized:           user.initialized,
               has_a_collection:      user.has_a_collection,
               email_missing:         user.email_missing,
               default_widget_key:    user.default_widget_key,
               default_playlist_id:   user.default_playlist_id,
               default_cms_page_id:   user.default_cms_page_id,
               writer:                user.writer, 
               author:                user.author,
               producer:              user.producer,
               composer:              user.composer,
               remixer:               user.remixer,
               musician:              user.musician,
               dj:                    user.dj,
               artist:                user.artist,
               profession:            user.profession,
               country:               user.country,
               city:                  user.city,
               completeness:          user.completeness,
               featured:              user.featured,
               featured_date:         user.featured_date,
               gender:                user.gender,
               link_to_facebook:      user.link_to_facebook,
               link_to_twitter:       user.link_to_twitter,  
               link_to_linkedin:      user.link_to_linkedin,
               link_to_google_plus:   user.link_to_google_plus,
               link_to_tumblr:        user.link_to_tumblr,
               link_to_instagram:     user.link_to_instagram,
               link_to_youtube:       user.link_to_youtube,
               link_to_homepage:      user.link_to_homepage,
               page_style_id:         user.page_style_id,
               top_tag:               user.top_tag,
               backdrop_image:        user.backdrop_image,

             }
      begin
        user.save!
      rescue 
        ap user.email
        user.save(validate: false)
      end
    
    
  end











end