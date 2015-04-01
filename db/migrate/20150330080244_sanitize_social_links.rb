class SanitizeSocialLinks < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.link_to_facebook            = LinkValidator.sanitize( user.link_to_facebook   ) 
      user.link_to_twitter             = LinkValidator.sanitize( user.link_to_twitter    ) 
      user.link_to_linkedin            = LinkValidator.sanitize( user.link_to_linkedin   ) 
      user.link_to_google_plus         = LinkValidator.sanitize( user.link_to_google_plus) 
      user.link_to_tumblr              = LinkValidator.sanitize( user.link_to_tumblr     ) 
      user.link_to_instagram           = LinkValidator.sanitize( user.link_to_instagram  ) 
      user.link_to_youtube             = LinkValidator.sanitize( user.link_to_youtube    ) 
      user.link_to_homepage            = LinkValidator.sanitize( user.link_to_homepage   ) 
      user.save(:validate => false)
    end
  end
end
