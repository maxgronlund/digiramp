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
  
  when "Users page"
    visit "/admin/users"
  
  when "Edit user page"
    visit "/admin/users/max-groenlund/edit"
  
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
