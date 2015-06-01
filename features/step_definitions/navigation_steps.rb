#require 'test/unit'
#include Test::Unit::Assertions

def visit_page page
  #sleep(3)
  case page
  when "Front Page"
    visit "/"
  
  when "Admin page"
    visit "/admin"
  
  when "Accounts page"
    visit "/admin/accounts"
  
  when "Accounts page"
    visit "/admin/accounts"
  
  when "Account info page"
    visit "/admin/accounts/1"
  
  when "Edit account page"
    visit "/admin/accounts/1/edit"
  
  when "Admin users page"
    visit "/admin/users"
  
  when "Content page"
    visit "/admin/content"
  
  when "Blogs page"
    visit "/admin/blogs"
  
  when "Blog page"
    visit "/admin/blogs/1"
  
  when "Edit post page"
    visit "/admin/blogs/1/blog_posts/1/edit"
  
  when "Tags page"
    visit "/admin/tags"
  
  when "Genres page"
    visit "/admin/genres"
  
  when "New genre page"
    visit "/admin/genres/new"
  
  when "Instruments page"
    visit "/admin/instruments"
  
  when "New instrument page"
    visit "/admin/instruments/new"
  
  when "Moods page"
    visit "/admin/moods"
  
  when "New mood page"
    visit "/admin/moods/new"
  
  when "Pro affiliations page"
    visit "/admin/pro_affiliations"
  
  when "New pro affiliations page"
    visit "/admin/pro_affiliations/new"
    
    
  #business
  when "Business page"
    visit "/admin/business/index"
  
  #when "Sales page"
  #  visit "/admin/sales"
  
  when "Subscriptions page"
    visit "/admin/subscriptions"
  
  when "Account types features page"
    visit "/admin/account_features"
  
  when "New account type features page"
    visit "/admin/account_features/new"
    

  when "Sales page"
    visit "/sales"
  

  when "Public shop page"
    visit "/shop"
    
  when "A not existing users recording page"
    visit "/users/not-existing/recordings/123456"
    
  when "A not existing recording page"
    user = User.first
    visit "/users/#{user.slug}/12346"
    
  when "A not existing message"
    user = User.first
    visit "/users/#{user.slug}/messages/123456"
    
    
  # member pages
  when "User account settings page"
    user = User.first
    visit "/user/users/#{user.slug}/control_panel"
    
  when "User contacts page"
    user = User.first
    visit "/user/users/#{user.slug}/contacts"
    
  when "New user contacts page"
    user = User.first
    visit "/user/users/#{user.slug}/contacts/new"
    
  when "User contact groups page"
    user = User.first
    visit "/user/users/#{user.slug}/contact_groups"
    
  when "New user contact group page"
    user = User.first
    visit "/user/users/#{user.slug}/contact_groups/new"
    
  when "User campaigns page"
    user = User.first
    visit "/user/users/#{user.slug}/campaigns"
    
  when "User campaigns page"
    user = User.first
    visit "/user/users/#{user.slug}/campaigns"
    
  when "New user campaigns page"
    user = User.first
    visit "/user/users/#{user.slug}/campaigns/new"
    
  when "User pages page"
    user = User.first
    visit "/user/users/#{user.slug}/cms_pages"
    
  when "New user pages page"
    user = User.first
    visit "/user/users/#{user.slug}/cms_pages/new"
    
  when "User creative rights page"
    user = User.first
    visit "/user/users/#{user.slug}/creative_rights"
    
  when "User IPIs & Credits page"
    user = User.first
    visit "/user/users/#{user.slug}/ipis"
    
  when "User positions page"
    user = User.first
    visit "/user/users/#{user.slug}/user_positions"
    
  when "User emails page"
    user = User.first
    visit "/user/users/#{user.slug}/user_emails"
    
  when "New user email page"
    user = User.first
    visit "/user/users/#{user.slug}/user_emails/new"
    
  when "Edit user social links page"
    user = User.first
    visit "/user/social_links/#{user.slug}/edit"
    
  when "User shop admin page"
    user = User.first
    visit "/user/users/#{user.slug}/shop_admin"
    
  when "User shop select product type page"
    user = User.first
    visit "/user/users/#{user.slug}/select_product_type"
    
  when "User special offers page"
    user = User.first
    visit "/user/users/#{user.slug}/special_offer"
    
  when "Edit contact info page"
    user = User.first
    visit "/user/user_addresses/#{user.slug}/edit"
    
  when "User special offers page"
    user = User.first
    visit "/user/users/#{user.slug}/special_offer"
    
  when "User subscriptions page"
    user = User.first
    visit "/user/users/#{user.slug}/subscriptions"
    
  when "User creative projects page"
    user = User.first
    visit "/user/users/#{user.slug}/creative_projects"
    
    
    
    
  
  # public pages
  when "Public songs page"
    visit "/songs?clear=clear"
    
  when "Public users page"
    visit "/users?clear=clear"
    
  when "Public recordings page"
    visit "/songs?clear=clear"
    
  when "Public opportunities page"
    visit "/public_opportunities?clear=clear"
    
  when "Public news page"
    visit "/news"
    
  when "Sign up page"
    visit "/signup/index"
    
  
  
  when "Sales board"
    visit "/sales/dashboard"
  
  when "Custom coupons board"
    visit "/sales/coupon_batches"
    
  when "Admin coupons page"
    visit "/admin/coupons"
  else
    visit "page not found"
  end
end
