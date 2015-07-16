# cucumber features/admin/coupon.feature:16 -r features

Feature:
As an administrator I can manage coupons

  Background:
    Given I am logged in as administrator
    And there is a plan named "DigiRAMP Pro" linked to an account type named "DigiRAMP Pro"

    
  #@javascript  
  Scenario: As an administrator i can view the coupon page
    When I'm on the "Admin coupons page"
    Then I can see "Coupons"
    
  @javascript  
  Scenario: As an administrator i create a new coupon 
    When I'm on the "Admin coupons page"
    Then I create a new coupon named "FREE-FUN"
    Then I can see "FREE-FUN"
    

  #Scenario: As an administrator i can not create two coupons with the same name 
  #  When I'm on the "Admin coupons page"
  #  Then I create a new coupon named "FREE-FUN"
  #  Then I can see "FREE-FUN"
#    
#  @javascript  
#  Scenario: As an administrator i create a set of coupons for an institution  
#    When I'm on the "Admin coupons page"
#    Then I create a new coupon named "FREE-FUN"
#    Then I can see "FREE-FUN"
    