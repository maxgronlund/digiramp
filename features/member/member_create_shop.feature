# cucumber features/member/member_create_shop.feature:10 -r features

Feature:
As an member I can create a shop

  Background:
    Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And I'm logged in as "user@digiramp.com" with the password "sesamsesamlukdigop"
  
  @javascript   
  Scenario: As a member I can create my personal shop
    #When I'm on the admin shop pages for the user with the email "user@digiramp.com"
    When I'm on the "User account settings page"
    Then I can see "Commerce engine"
    Then I clik on the link with the id "commerce"
    Then I can see "Shop administration"
    Then I clik on the link with the id "shop-administration"
    Then I can see "Create a DigiRAMP shop"
    #Then I can see "Register your account"
    #Then I can see "DigiRAMP charges"
    #Then I can see "Terms of usage"
    #When I click on the button "Continue"
    #Then i can see "You have to agree to the terms"
    #Then I'm enabling the checkbox "I understand and aggree to the terms"
    #When I click on the button "Continue"
    #Then I can see "Edit terms of usage"
    #Then I fill in the edit terms form
    #When I click on the button "Continue"
    #Then I can see "Edit company info"
    #Then I fill in company info form
    #When I click on the button "Continue"
    #Then I can see "Fill in bank informations"
    #Then I can see "Skip"
    #When I click on the button "Continue"
    #When I click on the button "Congratulation your shop is ready to use"

    
    
 
#  @javascript  
#  Scenario: As a member I can create a downloadable product
#    When I'm on the admin shop pages for the user with the email "user@digiramp.com"
#    Then I clik on the link with the id "new-product"
#    Then I can see "Select product type"
#    Then I clik on the link with the id "new-download-product"
#    Then I fill the download product form form with title: "Protools project", price: "1200", forsale: "true", type: "Music project" and a license
#    When I go the shop for "user@digiramp.com"
#    Then I can see "Music project"
#    Then I can see "Protools project"
#    Then I can see "1200"
#    Then I can see "Music project"
#    When I go to the public shop and select "downloadable-products"
#    Then I can see "Protools project"
#    
#  @javascript  
#  Scenario: As a member I can create a service product
#    When I'm on the admin shop pages for the user with the email "user@digiramp.com"
#    Then I clik on the link with the id "new-product"
#    Then I can see "Select product type"
#    Then I clik on the link with the id "new-service-product"
#    Then I fill the service product form form with title: "Wedding concert", price: "15000", forsale: "true", type: "Live performance"
#    When I go the shop for "user@digiramp.com" 
#    Then I can see "Wedding concert"
#    Then I can see "1500"
#    When I look at the product details for "wedding-concert"
#    Then I can see "Wedding concert"
#    When I go to the public shop and select "service-products"
#    Then I can see "Wedding concert"
#    
#  @javascript  
#  Scenario: As a member I can create a licence product
#    When I'm on the admin shop pages for the user with the email "user@digiramp.com"
#    Then I clik on the link with the id "new-product"
#    Then I can see "Select product type"
#    Then I clik on the link with the id "new-license-product"
#    Then I fill the service license form form with title: "Open your hard", price: "1500000", forsale: "true", type: "Sync license"
#    When I go the shop for "user@digiramp.com" 
#    Then I can see "Open your hard"
#    Then I can see "1500000"
#    When I look at the product details for "open_your_hard"
#    Then I can see "Open your hard"
#    When I go to the public shop and select "sync-licences"
#    Then I can see "Open your hard"