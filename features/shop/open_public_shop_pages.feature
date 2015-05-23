# cucumber features/shop/open_public_shop_pages.feature -r features

Feature:
As an guest I can se the shop pages

  Background:
    Given there is a product calles "Chunky beacon"


    
    
    
  @javascript  
  Scenario: As
    When I'm on the "Public shop page"
    Then I can see "Chunky beacon"

#