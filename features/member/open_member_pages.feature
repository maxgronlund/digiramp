# cucumber features/member/open_member_pages.feature -r features

Feature:
As an member I can create custom pages and add content to them

  Background:
    Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And I'm logged in as "user@digiramp.com" with the password "sesamsesamlukdigop"
    
    
    
  #@javascript  
  
  Scenario: As a member can open pages from my controll panel
  
   When I'm on the "User account settings page"
   Then I can see "Account settings"
   
   When I'm on the "User contacts page"
   Then I can see "Contacts"
   
   When I'm on the "New user contacts page"
   Then I can see "Add contacts"
   
   When I'm on the "User contact groups page"
   Then I can see "Contact groups"
   
   When I'm on the "New user contact group page"
   Then I can see "New contact group"
   
   When I'm on the "User campaigns page"
   Then I can see "Campaigns"
   
   When I'm on the "New user campaigns page"
   Then I can see "New campaign"
   
   When I'm on the "User pages page"
   Then I can see "Pages"
   
   When I'm on the "New user pages page"
   Then I can see "New page"
   
   When I'm on the "User creative rights page"
   Then I can see "Creative rights"
   
   When I'm on the "User IPIs & Credits page"
   Then I can see "IPI's & Credits"
   
   When I'm on the "User positions page"
   Then I can see "Positions"
   
   When I'm on the "User emails page"
   Then I can see "Additional emails"
   
   When I'm on the "New user email page"
   Then I can see "Add email"
   
   When I'm on the "User shop admin page"
   Then I can see "Shop administration"
   
   When I'm on the "User shop admin page"
   Then I can see "Shop administration"
   
   When I'm on the "User shop select product type page"
   Then I can see "Select product type"
   
   When I'm on the "User special offers page"
   Then I can see "Special offers"
   
   When I'm on the "Edit user social links page"
   Then I can see "Edit Social links"
   
   When I'm on the "Edit contact info page"
   Then I can see "Edit contact info"
   
   When I'm on the "User subscriptions page"
   Then I can see "Plans"
   
   When I'm on the "User creative projects page"
   Then I can see "Creative projects"
   
   
   
    
    
    

    

  