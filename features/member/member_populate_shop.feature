# cucumber features/member/member_populate_shop.feature -r features

Feature:
As an member I can create a shop and add products to it

  Background:
    Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    And I'm logged in as "user@digiramp.com" with the password "sesamsesamlukdigop"
    

    
    
    
  @javascript  
  Scenario: As a member I can create a physical product
    When I'm on the admin shop pages for the user with the email "user@digiramp.com"
    Then I can see "Shop administration"
    Then I clik on the link with the id "new-product"
    Then I can see "Select product type"
    Then I clik on the link with the id "new-physical-product"
    Then I fill the physical product form form with title: "Golden guitar", price: "12000", forsale: "true", show in public shop: "true", units in stock: "50", Info on badges, "Real cool shoffel", Description: "Gold plate real cool shoffel", delivery_time: "3-4 days", shipping_cost: "5", 
    When I go the shop for "user@digiramp.com" 
    Then I can see "Golden guitar"
    When I look at the product details for "golden-guitat"
    Then I can see "Golden guitar"
    Then I can see "$120.00" 
    #Then I can see "100x100"
    #Then I can see "10.00"
    #Then I can see "2 lb"
    #When I go to the public shop and select "physical-products"
    #Then I can see "Golden guitar"
    #When I look at the product details for "golden-guitat"
    #Then I can see "Golden guitar"
    
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