# cucumber features/account_user/open_account_user_pages.feature -r features

Feature:
As an member I can create custom pages and add content to them

  Background:
    Given  there is a user with the email "account_user@digiramp.com" and the password "corect-horse-battery-stable" 
    And there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And  there user with the email "account_user@digiramp.com" is an account user on the account for the user with the email "user@digiramp.com"
    And I'm logged in as "account_user@digiramp.com" with the password "corect-horse-battery-stable"
    
    
    
    
  #@javascript  
  Scenario: As an account user I can open pages from my controll panel
   When I'm on the "User account settings page"
   Then I can see "Account you have access to"
   
   When I'm on the "User account accounts page"
   Then I can see "Account you have access to"
   
   When I'm on the account page for user with the email "user@digiramp.com"
   Then I can see "Account you have access to"
   
  
    

    

  