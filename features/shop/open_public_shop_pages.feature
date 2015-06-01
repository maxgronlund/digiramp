# cucumber features/shop/open_public_shop_pages.feature -r features

Feature:
As an guest I can se the public shop pages

  Background:
    Given there is a user with the email "user@digiramp.com" and the password "sesamsesamlukdigop"
    Given there is a product called "Chunky beacon"
    Given there is a product called "Happy coder"
    Given there is a product called "Light house"


    
    
    
  @javascript  
  Scenario: As guest i can go to the shop and buy a product
    When I'm on the "Public shop page"
    Then I can see "Chunky beacon"
    Then I clik on the link with the id "chunky_beacon"
    Then I can see "Chunky beacon"
    When I click on the button "Add to basket"
    Then I can see "1 Item"
    When I click on the button "Add to basket"
    Then I can see "2 Items"
    When I'm on the "Public shop page"
    Then I can see "Happy coder"
    Then I clik on the link with the id "happy_coder"
    Then I can see "Happy coder"
    When I click on the button "Add to basket"
    Then I can see "3 Items"
    Then I clik on the link with the id "checkout"
    Then I can see "Happy coder"
    Then I can see "Chunky beacon"
    Then I clik on the link with the id "payment_form"
    #Then I fill in the payment form with wrong data and save
