# cucumber features/sales/create_special_coupon.feature:22 -r features

Feature:
As an salesperson I can make special offers to customers and sell them coupons

  Background:
    Given I am logged in as a salesperson with the email "sales@digiramp.com"
    And there is a plan named "DigiRAMP Pro" linked to an account type named "DigiRAMP Pro"
    #Given I am the administrator
    #And I am logged in
    
  @javascript  
  Scenario: As a salesperson I can se the sales section
    When I'm on the "Sales board"
    Then I can see "Sales"
    
  @javascript  
  Scenario: As a salesperson I can se the coustom coupons
    When I'm on the "Custom coupons board"
    Then I can see "Coupon batches"
    
  @javascript  
  Scenario: As an salesperson I can create a new coupon and send an offer to a customer
    When I'm on the "Custom coupons board"
    Then I clik on the link with the id "new-coupon-batch"
    Then I can see "New coupon"
    Then I fill the custom coupon form and save
    Then I can se the list of uniq coupon codes
    
  #@javascript  
  #Scenario: As an salesperson I can try to create a new coupon but enter some invalid data
  #  When I'm on the "Custom coupons board"
  #  Then I clik on the link with the id "new-coupon-batch"
  #  Then I can see "New coupon"
  #  Then I fill the custom coupon form with invalid data and save
  #  Then I can se the list of uniq coupon codes

    
    
    
