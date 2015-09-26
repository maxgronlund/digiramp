# cucumber features/account_user/open_account_user_pages.feature -r features

Feature:
As an member I can create custom pages and add content to them

  Background:
    Given  there is a user with the email "account_user@digiramp.com" and the password "corect-horse-battery-stable" 
    And there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And  there user with the email "account_user@digiramp.com" is an account user on the account for the user with the email "user@digiramp.com"
    And I'm logged in as "account_user@digiramp.com" with the password "corect-horse-battery-stable"
    
    
    
    
  @javascript  
  Scenario: As an account user I can open pages from my controll panel
   When I'm on the "User account settings page"
   Then I can see "Account you have access to"
   
   When I'm on the "User account accounts page"
   Then I can see "Account you have access to"

   
   When I'm on the account page for user with the email "user@digiramp.com"
   Then I can see "0 Recordings"
   Then I can see "0 Opportunities"
   #Then Does it look right
   Then I can see "1 User"
   Then I can see "0 Works"
   Then I can see "0 Catalogs"
   Then I can see "CRM"
   Then I can see "IPI Codes"
   Then I can see "Documents"
   
   When I'm on the recordings page for user with the email "user@digiramp.com"
   Then I can see "Add recordings"
   
   When I'm on the opportunities page for user with the email "user@digiramp.com"
   Then I can see "New opportunity"
   
   When I'm on the users page for user with the email "user@digiramp.com"
   Then I can see "Invite user"
   
   When I'm on the works page for user with the email "user@digiramp.com"
   Then I can see "New common work"
   
   When I'm on the catalogs page for user with the email "user@digiramp.com"
   Then I can see "Create catalog"
   
   When I'm on the CRM page for user with the email "user@digiramp.com"
   Then I can see "Customer Relation Management"
   
   When I'm on the IPI codes page for user with the email "user@digiramp.com"
   Then I can see "Add IPI code"
   
   When I'm on the documents page for user with the email "user@digiramp.com"
   Then I can see "Artwork"
   Then I can see "Legal"
   Then I can see "Financial"
   Then I can see "Recording bucket"

   
  
    

    

  